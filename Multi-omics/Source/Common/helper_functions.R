##################################################################################################################

### Function: create_id_to_attribute_hash
### Description: Create a hash function that map keys to attributes. 
### Author: Ignaitus Pang ` i.pang at unsw.edu.au '

## Inputs: 
## keys: An array of key values
## attributes: An array of attribute values

## Output:
## An environment that act as a hash to convert keys to attributes. 

create_id_to_attribute_hash <- function(  keys, attributes) {
	
	keys <- as.character( as.vector(keys))
	attribute <- as.vector(attributes)
	
	hash <- new.env(hash = TRUE, parent = parent.frame())
	
	if ( length(keys) != length(attributes))  {
		warning('Length of keys != Length of attributes list.')
		return(1)
	}
	
	for ( i in 1:length(keys) )  {
		base::assign( keys[i], attributes[i], envir = hash)                       
	}
	
	return(hash)
}

##################################################################################################################

### Function: create_id_to_attribute_hash
### Description: Use a predefined hash dictionary to convert any Key to Attribute, return NA if key does not exists

## Inputs: 
## key: A key value
## hash: The hash dictionary that maps keys to attributes

## Output:
## A value that correspond to the query key value. 

convert_key_to_attribute <- function(key, hash) { 
	
	if ( base::exists(key, hash) ) {
		return ( base::get(key, hash)) 
	}
	else { 
		return (NA)
	}
}

##################################################################################################################


create_directory_if_not_exists <- function(file_path, mode = "0777") { 
	
	### Create directory recursively if it doesn't exist
	if (! file.exists(file_path)){
		
		dir.create(file_path, showWarnings = TRUE, recursive = TRUE, mode = mode)
		
	}
	
}

create_dir_if_not_exists <- create_directory_if_not_exists


##################################################################################################################

## Function to source Rmd files 
# https://stackoverflow.com/questions/10966109/how-to-source-r-markdown-file-like-sourcemyfile-r
source_rmd_file_simple <- function(x, ...) {
	source(purl(x, output = tempfile()), ...)
}

##################################################################################################################

#' https://gist.github.com/noamross/a549ee50e8a4fd68b8b1
#' Source the R code from an knitr file, optionally skipping plots
#'
#' @param file the knitr file to source
#' @param skip_plots whether to make plots. If TRUE (default) sets a null graphics device
#'
#' @return This function is called for its side effects
#' @export
source_rmd_file <- function(file, skip_plots = TRUE) {
	temp = tempfile(fileext=".R")
	knitr::purl(file, output=temp)
	
	if(skip_plots) {
		old_dev = getOption('device')
		options(device = function(...) {
			.Call("R_GD_nullDevice", PACKAGE = "grDevices")
		})
	}
	source(temp)
	if(skip_plots) {
		options(device = old_dev)
	}
}


##################################################################################################################
