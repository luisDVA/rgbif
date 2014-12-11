#' Search for catalog numbers, collection codes, collector names, and institution
#' codes.
#'
#' @import httr plyr
#' @export
#'
#' @param type Type of data, one of catalog_number, collection_code, collector_name,
#' institution_code. Unique partial strings work too, like 'cat' for catalog_number
#' @param q Search term
#' @param limit Number of results, default=5
#' @param pretty Pretty as true (Default) uses cat to print data, FALSE gives
#' character strings.
#' @param ... Further named parameters, such as \code{query}, \code{path}, etc, passed on to
#' \code{\link[httr]{modify_url}} within \code{\link[httr]{GET}} call. Unnamed parameters will be
#' combined with \code{\link[httr]{config}}.
#'
#' @references \url{http://www.gbif.org/developer/occurrence#search}
#'
#' @examples 
#' \donttest{
#' # catalog number
#' occ_metadata(type = "catalogNumber", q=122)
#'
#' # collection code
#' occ_metadata(type = "collectionCode", q=12)
#' }
#' 
#' \dontrun{
#' # institution code
#' occ_metadata(type = "institutionCode", q='GB')
#'
#' # data as character strings
#' occ_metadata(type = "catalogNumber", q=122, pretty=FALSE)
#'
#' # Change number of results returned
#' occ_metadata(type = "catalogNumber", q=122, limit=10)
#'
#' # Partial unique type strings work too
#' occ_metadata(type = "cat", q=122)
#'
#' # Pass on options to httr
#' library('httr')
#' occ_metadata(type = "cat", q=122, config=verbose())
#' occ_metadata(type = "cat", q=122, config=progress())
#'
#' # FAILS: collector name - collector_name endpoint down on 2014-04-23
#' occ_metadata(type = "collector_name", q='jane')
#' }

occ_metadata <- function(type = "catalogNumber", q=NULL, limit=5, pretty=TRUE, ...)
{
  type <- match.arg(type, c("catalogNumber","collectionCode","collectorName","institutionCode"))
  url <- sprintf('%s/occurrence/search/%s', gbif_base(), type)
  args <- rgbif_compact(list(q = q, limit = limit))
  out <- gbif_GET(url, args, TRUE, ...)

  if(pretty)
    cat(out, sep="\n")
  else
    out
}
