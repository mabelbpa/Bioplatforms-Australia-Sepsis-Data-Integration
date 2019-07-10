#/bin/perl -w 

### author: Ignaitus Pang ` i.pang at unsw.edu.au '


use warnings; 
use LWP::Simple;

my $global_output_dir = "/home/ignatius/PostDoc/2019/Sepsis/Data/Proteome_File_Per_Chromosome";
my $LIST_OF_ACCESSIONS = "/home/ignatius/PostDoc/2019/Sepsis/Data/Genomes_List/List_of_annotation_accessions.txt";

sub get_one_fasta ($$) {

	my($output_dir, $term) = @_;

	if ( ! -e "$output_dir/$term.faa") {

		my	$base = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/';


		my	$url = $base. "esearch.fcgi?db=nuccore&term=$term&usehistory=y";

    print $url, "\n";
			#post the elink URL
		my	$output1 = get($url);

			#parse WebEnv and QueryKey
		my	$uid = $1 if ($output1 =~ /<Id>(\S+)<\/Id>/); 

			print "\$term = $term, \$uid = $uid\n";

			# Download gene records linked to a set of proteins corresponding to a list
			# of GI numbers.
		my	$db1 = 'nuccore';  # &dbfrom
		my	$db2 = 'protein';     # &db
		my	$linkname = 'nuccore_protein'; # desired link &linkname
			#input UIDs in $db1 (protein GIs)
		my	$id_list = $uid; # '1574394220';

			#assemble the elink URL
		my	$url2 = $base . "elink.fcgi?dbfrom=$db1&db=$db2&id=$id_list";
			$url2 .= "&linkname=$linkname&cmd=neighbor_history";

    print $url2, "\n";


			#post the elink URL
		my	$output2 = get($url2);

			#parse WebEnv and QueryKey
		my	$web = $1 if ($output2 =~ /<WebEnv>(\S+)<\/WebEnv>/);
		my	$key = $1 if ($output2 =~ /<QueryKey>(\d+)<\/QueryKey>/);
		
		# if( ! defined $key ) {
		#   $key = 1;
		# }

			#########################################
		my	$url3 = $base . "efetch.fcgi?db=$db2&query_key=$key&WebEnv=$web";
			  $url3 .= "&rettype=fasta&retmode=text&idtype=uid"; # acc

			#post the efetch URL
			$fasta_data = get($url3);

			open(OUT, "> $output_dir/$term.faa") || die "Can't open file!\n";

			print OUT "$fasta_data";

	}
}

# get_one_fasta ( $global_output_dir, "NZ_LR130239.1" )


open( IDLIST, "< $LIST_OF_ACCESSIONS") || die "Can't open file!\n";

while ( <IDLIST>) {
   my $cleaned_id = $_;

   $cleaned_id =~ s/\s+$//g; 

   print $cleaned_id."\n";
   get_one_fasta ( $global_output_dir, $cleaned_id );

}




