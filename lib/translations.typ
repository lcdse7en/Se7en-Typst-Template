#let value(en: "", zh: "") = {
  context {
    if text.lang == "en" {
      return en
    }

    if text.lang == "zh" {
      return zh
    }

    return "Unknown language"
  }
}

#let translations = (
  bachelor-thesis: value(
    en: "Bachelor thesis",
    zh: "Bachelorarbeit",
  ),
  master-thesis: value(
    en: "Master thesis",
    zh: "Masterarbeit",
  ),
  faculty-of: value(
    en: "Faculty of",
    zh: "",
  ),
  department-of: value(
    en: "Department of",
    zh: "",
  ),
  bachelor-thesis-submitted-for-examination-in-bachelors-degree: value(
    en: "Bachelor thesis submitted for examination in Bachelor's degree",
    zh: "Bachelorarbeit eingereicht im Rahmen der Bachelorprüfung",
  ),
  master-thesis-submitted-for-examination-in-masters-degree: value(
    en: "Master thesis submitted for examination in Master's degree",
    zh: "Masterarbeit eingereicht im Rahmen der Masterprüfung",
  ),
  in-the-study-course: value(
    en: "in the study course",
    zh: "im Studiengang",
  ),
  at-the-department: value(
    en: "at the Department",
    zh: "am Department",
  ),
  at-the-faculty-of: value(
    en: "at the Faculty of",
    zh: "der Fakultät",
  ),
  at-university-of-applied-science-hamburg: value(
    en: "at University of Applied Science Hamburg",
    zh: "der Hochschule für Angewandte Wissenschaften Hamburg",
  ),
  supervising-examiner: value(
    en: "Supervising examiner",
    zh: "Betreuender Prüfer",
  ),
  second-examiner: value(
    en: "Second examiner",
    zh: "Zweitgutachter",
  ),
  submitted: value(
    en: "Submitted",
    zh: "Eingereicht am",
  ),
  list-of-figures: value(
    en: "List of Figures",
    zh: "Abbildungsverzeichnis",
  ),
  list-of-tables: value(
    en: "List of Tables",
    zh: "Tabellenverzeichnis",
  ),
  listings: value(
    en: "Listings",
    zh: "Listings",
  ),
  declaration-of-independent-processing: value(
    en: "Declaration of Independent Processing",
    zh: "Erklärung zur selbstständigen Bearbeitung",
  ),
  declaration-of-independent-processing-content: value(
    en: "I hereby certify that I wrote this work independently without any outside help and only used the resources specified. Passages taken literally or figuratively from other works are identified by citing the sources.",
    zh: "Hiermit versichere ich, dass ich die vorliegende Arbeit ohne fremde Hilfe selbständig verfasst und nur die angegebenen Hilfsmittel benutzt habe. Wörtlich oder dem Sinn
nach aus anderen Werken entnommene Stellen sind unter Angabe der Quellen kenntlich gemacht.",
  ),
  place: value(
    en: "Place",
    zh: "Ort",
  ),
  date: value(
    en: "Date",
    zh: "Datum",
  ),
  signature: value(
    en: "Original Signature",
    zh: "Unterschrift im Original",
  ),
)
