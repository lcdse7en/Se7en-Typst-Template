#let report(
  paper-size: "a4",
  font-size: 11pt,
  language: "en",
  title: "",
  subtitle: "",
  author: (),
  logo: none,
  cover: none,
  image-index: none,
  main-color: blue,
  copyright: [],
  list-of-figure-title: none,
  list-of-table-title: none,
  part-style: 0,
  supplement-chapter: "Chapter",
  faculty: "",
  department: "",
  date: "",
  include-declaration-of-independent-processing: false,
  body,
) = {
  import "template.typ": template
  template(
    paper-size: paper-size,
    font-size: font-size,
    is-thesis: false,
    is-master-thesis: false,
    is-bachelor-thesis: false,
    is-report: true,

    language: language,

    title-zh: title,

    subtitle: subtitle,
    keywords-zh: none,
    abstract-zh: none,

    title-en: title,
    keywords-en: none,
    abstract-en: none,

    author: author,

    cover: cover,
    logo: logo,
    image-index: image-index,
    copyright: copyright,
    list-of-figure-title: list-of-figure-title,
    list-of-table-title: list-of-table-title,
    main-color: main-color,
    part-style: part-style,
    supplement-chapter: supplement-chapter,

    faculty: faculty,
    department: department,
    study-course: none,
    supervisors: (),
    date: date,
    include-declaration-of-independent-processing: include-declaration-of-independent-processing,
    body,
  )
}

#let bachelor-thesis(
  language: "en",
  title-zh: "",
  keywords-zh: none,
  abstract-zh: none,
  title-en: none,
  keywords-en: none,
  abstract-en: none,
  author: "",
  faculty: "",
  department: "",
  study-course: "",
  supervisors: (),
  submission-date: none,
  include-declaration-of-independent-processing: true,
  body,
) = {
  import "template.typ": template
  template(
    is-thesis: true,
    is-master-thesis: false,
    is-bachelor-thesis: true,
    is-report: false,

    language: language,

    title-zh: title-de,
    keywords-zh: keywords-de,
    abstract-zh: abstract-de,

    title-en: title-en,
    keywords-en: keywords-en,
    abstract-en: abstract-en,

    author: author,
    faculty: faculty,
    department: department,
    study-course: study-course,
    supervisors: supervisors,
    submission-date: submission-date,
    include-declaration-of-independent-processing: include-declaration-of-independent-processing,
    body,
  )
}

#let master-thesis(
  language: "en",
  title-zh: "",
  keywords-zh: none,
  abstract-zh: none,
  title-en: none,
  keywords-en: none,
  abstract-en: none,
  author: "",
  faculty: "",
  department: "",
  study-course: "",
  supervisors: (),
  submission-date: none,
  include-declaration-of-independent-processing: true,
  body,
) = {
  import "template.typ": template
  template(
    is-thesis: true,
    is-master-thesis: true,
    is-bachelor-thesis: false,
    is-report: false,

    language: language,

    title-zh: title-de,
    keywords-zh: keywords-de,
    abstract-zh: abstract-de,

    title-en: title-en,
    keywords-en: keywords-en,
    abstract-en: abstract-en,

    author: author,
    faculty: faculty,
    department: department,
    study-course: study-course,
    supervisors: supervisors,
    submission-date: submission-date,
    include-declaration-of-independent-processing: include-declaration-of-independent-processing,
    body,
  )
}
