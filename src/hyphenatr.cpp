#include <Rcpp.h>
#include <string>
#include <algorithm>

#include "hyphen.h"

using namespace Rcpp;
using namespace std;

#define MAXWORDLEN 200
#define MAXHYPHLEN MAXWORDLEN*2

HyphenDict *dict = NULL;

// Set dictionary language
//
// @param dict_path path to the hyphen dictionary
// [[Rcpp::export]]
void init(std::string dict_path) {
  if (dict != NULL) hnj_hyphen_free(dict);
  dict = hnj_hyphen_load(dict_path.c_str());
}

// [[Rcpp::export]]
void cleanup() {
  if (dict != NULL) hnj_hyphen_free(dict);
}

//' Test to see if the hyphenation language rules dictionary is loaded
//'
//' @export
//' @note The \code{en_US} hyphenation rules dictionary is loaded by default
// [[Rcpp::export]]
LogicalVector hyphendict_is_loaded() {
  return(dict != NULL);
}

// [[Rcpp::export]]
std::vector < std::string > hyphenate(std::vector < std::string > words) {

  if (dict == NULL) return(words);

  char** rep = NULL;
  int* pos = NULL;
  int* cut = NULL;
  char hyphens[MAXWORDLEN];
  char hyphenword[MAXHYPHLEN];

  unsigned int words_size = words.size();
  std::vector < std::string > output(words_size);

  for (unsigned int i = 0; i < words_size; i++) {

    if ((i % 10000) == 0) { Rcpp::checkUserInterrupt(); }

    if (!hnj_hyphen_hyphenate2(dict, words[i].c_str(), words[i].length(),
                              hyphens, hyphenword, &rep, &pos, &cut)) {
      output[i] = std::string(hyphenword);
    } else {
      output[i] = words[i];
    }

  }

  return(output);

}
