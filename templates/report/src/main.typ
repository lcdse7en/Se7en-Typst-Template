#import "@preview/se7en:0.1.0": report
#import "dependencies.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: report.with(
  language: "en",
  title: "Answer to the Ultimate Question of Life, the Universe, and Everything",
  author: "The Computer",
  faculty: "Engineering and Computer Science",
  department: "Computer Science",
  include-declaration-of-independent-processing: true,
  submission-date: datetime(day: 1, month: 3, year: 2024),
)

// Enable glossary
// Use: @key or @key:pl to reference and #print-glossary to print it
// More documentation: https://typst.app/universe/package/glossarium/
#show: make-glossary
#import "glossary.typ": glossary-entry-list
#import "abbreviations.typ": abbreviations-entry-list
#register-glossary(glossary-entry-list)
#register-glossary(abbreviations-entry-list)

// Print abbreviations
#pagebreak(weak: true)
#heading("Abbreviations", numbering: none)
#print-glossary(abbreviations-entry-list, disable-back-references: true)

// Include chapters of thesis
#pagebreak(weak: true)
#include "chapters/01_introduction.typ"
#include "chapters/02_background.typ"

// Print glossary
#pagebreak(weak: true)
#heading("Glossary", numbering: none)
#print-glossary(glossary-entry-list, disable-back-references: true)

// Print bibliography
#pagebreak(weak: true)
#bibliography("bibliography.bib", style: "ieeetran.csl")
