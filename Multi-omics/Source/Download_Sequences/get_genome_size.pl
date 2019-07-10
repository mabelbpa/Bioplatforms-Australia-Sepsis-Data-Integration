#/usr/bin/perl -w 

### author: Ignaitus Pang ` i.pang at unsw.edu.au '

use warnings;

# https://www.ncbi.nlm.nih.gov/books/NBK25498/#chapter3.ESearch__ESummaryEFetch
use LWP::Simple;

# Download PubMed records that are indexed in MeSH for both asthma and 
# leukotrienes and were also published in 2009.


sub get_one_query(  $) {

		my ($query) = @_;


		$db = 'nucleotide';

		#assemble the esearch URL
		$base = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/';
		$url = $base . "esearch.fcgi?db=$db&term=$query&usehistory=y";

		#post the esearch URL
		$output = get($url);

		#parse WebEnv and QueryKey
		$web = $1 if ($output =~ /<WebEnv>(\S+)<\/WebEnv>/);
		$key = $1 if ($output =~ /<QueryKey>(\d+)<\/QueryKey>/);

		### include this code for ESearch-ESummary
		#assemble the esummary URL
		$url = $base . "esummary.fcgi?db=$db&query_key=$key&WebEnv=$web";

		#post the esummary URL
		$docsums = get($url);
		# print "$docsums";

		#### include this code for ESearch-EFetch
		##assemble the efetch URL
		#$url = $base . "efetch.fcgi?db=$db&query_key=$key&WebEnv=$web";
		#$url .= "&rettype=genbank"; # &retmode=xml

		##post the efetch URL
		#$data = get($url);
		#print "$data";


	$seq_length = $1 if ( $docsums =~ /<Item Name="Length" Type="Integer">(\d+)<\/Item>/ ) ;
	$accession = $1 if ( $docsums =~ /<Item Name="AccessionVersion" Type="String">([\w|\.]+)<\/Item>/ );

	my %return_data = ( "accession" => $accession, "seq_length" => $seq_length );

	return( \%return_data);

}

##my $query = 'NZ_LR595848.1';

### &get_one_query( $query );

my $length_of_sequences = "/home/ignatius/PostDoc/2019/Sepsis/Data/Genomes_List/sequence_sizes.txt";
my $LIST_OF_ACCESSIONS = "/home/ignatius/PostDoc/2019/Sepsis/Data/Genomes_List/List_of_annotation_accessions.txt";

open( IDLIST, "< $LIST_OF_ACCESSIONS") || die "Can't open file $LIST_OF_ACCESSIONS!\n";
open( SEQ_SIZE, "> $length_of_sequences") || die "Can't open file $length_of_sequences!\n";

while ( <IDLIST>) {
   my $cleaned_id = $_;

   $cleaned_id =~ s/\s+$//g; 

   print $cleaned_id."\n";
   my $hash_ref = &get_one_query( $cleaned_id );

   #print %{$hash_ref}, "\n";
   
   my $accession = ${$hash_ref}{"accession"};
   my $seq_length = $hash_ref->{"seq_length"};


   print  $accession, "\t", $seq_length,  "\n"	;

   print SEQ_SIZE $accession, "\t", $seq_length,  "\n"	;


}

close(IDLIST);
close(SEQ_SIZE);
