#import "../translations.typ": translations

#let CrossLine = align(left)[
  \ \
  #h(1fr)
  $#line(
start:(0em,-.15em),
end:(14em,-.15em),
stroke: (
  cap: "round",
  paint:gradient.linear(white,black,white)
)
)
#move(dx:.5em,dy:0em,"🙠")
  #text(15pt)[🙣]
  #h(0.4em)
  #move(dy:-0.25em,text(12pt)[✢])
  #h(0.4em)
  #text(15pt)[🙡]
  #move(dx:-.5em,dy:0em,"🙢")
  #line(
    start:(0em,-.15em),
    end:(14em,-.15em),
    stroke: (
      cap: "round",
      paint:gradient.linear(white,black,white)
    )
  )$
  #h(1fr)
  \ \
]

#let cover_page(
  is-thesis: true,
  is-master-thesis: false,
  is-bachelor-thesis: true,
  is-report: false,
  title: "",
  author: "",
  faculty: "",
  department: "",
  study-course: "",
  supervisors: (),
  submission-date: "",
  date: "",
) = {
  // Set the document's basic properties.
  set page(
    margin: (left: 0mm, right: 0mm, top: 0mm, bottom: 0mm),
    numbering: none,
    number-align: center,
  )

  // HAW Logo
  place(
    top + right,
    dx: -13mm,
    dy: 10mm,
    image("../assets/logo.svg", width: 164pt),
  )

  // Title etc.
  pad(
    left: 57mm,
    top: 66mm,
    right: 18mm,
    stack(
      // Type
      if is-thesis {
        let thesis-title = translations.bachelor-thesis
        if is-master-thesis {
          thesis-title = translations.master-thesis
        }
        upper(text(thesis-title, size: 9pt, weight: "bold"))
        v(2mm)
      },
      // Author
      text(author, size: 11pt, weight: "bold"),
      v(13mm),
      // Title
      CrossLine,
      [
        #set align(center)
        #par(
          first-line-indent: 0em,
          leading: 9pt,
          text(title, size: 22pt, weight: "bold"),
        )
      ],
      v(-20pt),
      CrossLine,
      // v(5mm),
      // line(start: (0pt, 0pt), length: 30pt, stroke: 1mm),
      v(17mm),
      // Faculty
      text(translations.faculty-of + " " + faculty, size: 11pt, weight: "bold"),
      v(2mm),
      // Department
      text(
        translations.department-of + " " + department,
        size: 11pt,
        weight: "bold",
      ),
      v(2mm),
      link("https://github.com/lcdse7en")[
        #align(right)[
          Github https://github.com/lcdse7en
        ]
      ],
      v(2mm),
      align(right)[
        Gmail seenliang969\@gmail.com
      ],
      v(2mm),
      align(right)[
        QQ 1534452927\@qq.com
      ],
      v(2mm),
      align(right)[
        QQ 2353442022\qq.com
      ],
      v(2mm),
      align(right)[
        Wechat se7enlcd
      ],
      v(6mm),
      align(center)[
        #text(weight: "bold", size: 11pt)[
          #date
        ]
      ],
    ),
  )

  // University name text
  place(
    right + bottom,
    dx: -11mm,
    dy: -35mm,
    box(
      align(
        left,
        stack(
          line(start: (0pt, 0pt), length: 25pt, stroke: 0.9mm),
          v(3mm),
          text("HOCHSCHULE FÜR ANGEWANDTE", size: 9pt, weight: "bold"),
          v(2mm),
          text("WISSENSCHAFTEN HAMBURG", size: 9pt, weight: "bold"),
          v(2mm),
          text("Hamburg University of Applied Sciences", size: 9pt),
        ),
      ),
    ),
  )

  if is-thesis {
    // Second cover page
    pagebreak()

    // Set the document's basic properties.
    set page(
      margin: (left: 31.5mm, right: 32mm, top: 55mm, bottom: 67mm),
      numbering: none,
      number-align: center,
    )

    // Title etc.
    stack(
      // Author
      align(
        center,
        text(author, size: 14pt),
      ),
      v(23mm),
      // Title
      align(
        center,
        par(
          leading: 13pt,
          text(title, size: 18pt),
        ),
      ),
      v(22mm),
    )

    v(1fr)

    stack(
      // Content
      stack(
        spacing: 3mm,
        if is-bachelor-thesis {
          text(
            translations.bachelor-thesis-submitted-for-examination-in-bachelors-degree,
          )
        },
        if is-master-thesis {
          text(
            translations.master-thesis-submitted-for-examination-in-masters-degree,
          )
        },
        text(
          translations.in-the-study-course
            + " "
            + text(study-course, style: "italic"),
        ),
        text(translations.at-the-department + " " + department),
        text(translations.at-the-faculty-of + " " + faculty),
        text(translations.at-university-of-applied-science-hamburg),
      ),

      v(4mm),
      line(start: (0pt, 0pt), length: 25pt, stroke: 1mm),
      v(4mm),

      // Supervision
      if supervisors.len() > 0 {
        if type(supervisors) != array {
          text(
            translations.supervising-examiner
              + ": "
              + text(upper(supervisors), weight: "bold"),
            size: 10pt,
          )
        } else {
          text(
            translations.supervising-examiner
              + ": "
              + text(upper(supervisors.first()), weight: "bold"),
            size: 10pt,
          )

          if supervisors.len() > 1 {
            linebreak()
            text(
              translations.second-examiner
                + ": "
                + text(upper(supervisors.at(1)), weight: "bold"),
              size: 10pt,
            )
          }
        }
      },

      // Submission date
      if submission-date != none {
        stack(
          v(4mm),
          line(start: (0pt, 0pt), length: 25pt, stroke: 1mm),
          v(4mm),
          text(
            translations.submitted
              + ": "
              + submission-date.display("[day]. [month repr:long] [year]"),
            size: 10pt,
          ),
        )
      },
    )
  }
}
