#let template(
  paper-size: "a4",
  font-size: 11pt,
  is-thesis: true,
  is-master-thesis: false,
  is-bachelor-thesis: true,
  logo: none,
  cover: none,
  image-index: none,
  copyright: [],
  list-of-figure-title: none,
  list-of-table-title: none,
  main-color: blue,
  part-style: 0,
  supplement-chapter: "Chapter",
  is-report: false,
  language: "en",
  title-zh: "",
  subtitle: "",
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
  date: "",
  include-declaration-of-independent-processing: false,
  body,
) = {
  let THESIS_HEADING_EXTRA_TOP_MARGIN = 70pt
  let PAGE_MARGIN_TOP = 18mm

  let title = title-zh
  if language == "en" {
    title = title-en
  }

  let title-main-1 = 2.5em
  let title-main-2 = 1.8em
  let title-main-3 = 2.2em
  let title1 = 2.2em
  let title2 = 1.5em
  let title3 = 1.1em
  let title4 = 1.1em
  let title5 = 11pt

  let outline-part = 1.5em
  let outline-heading1 = 1.3em
  let outline-heading2 = 1.1em
  let outline-heading3 = 1.1em

  let language-state = state("language-state", none)
  let main-color-state = state("main-color-state", none)
  let appendix-state = state("appendix-state", none)
  let appendix-state-hide-parent = state("appendix-state-hide-parent", none)
  let heading-image = state("heading-image", none)
  let supplement-part-state = state("supplement_part", none)
  let part-style-state = state("part-style", 0)
  let part-state = state("part-state", none)
  let part-location = state("part-location", none)
  let part-counter = counter("part-counter")
  let part-change = state("part-change", false)

  import "@preview/cuti:0.3.0": show-cn-fakebold
  show: show-cn-fakebold

  // Set the document's basic properties.
  set document(author: author, title: title, date: submission-date)
  set page(
    paper: paper-size,
    margin: (x: 2.2cm, bottom: 1.5cm, top: 1.8cm),
    header: context {
      set text(size: 11pt)
      let page_number = counter(page).at(here()).first()
      let odd_page = calc.odd(page_number)
      let part_change = part-change.at(here())
      // Are we on an odd page?
      // if odd_page {
      //   return text(0.95em, smallcaps(title))
      // }

      // Are we on a page that starts a chapter? (We also check
      // the previous page because some headings contain pagebreaks.)
      let all = query(heading.where(level: 1))
      if all.any(it => it.location().page() == page_number) or part_change {
        return
      }
      let appendix = appendix-state.at(here())
      if odd_page {
        let before = query(selector(heading.where(level: 2)).before(here()))
        let counterInt = counter(heading).at(here())
        if before != () and counterInt.len() > 1 {
          box(width: 100%, inset: (bottom: 5pt), stroke: (bottom: 0.5pt))[
            #text(if appendix != none {
              (
                numbering("A.1", ..counterInt.slice(0, 2))
                  + " "
                  + before.last().body
              )
            } else {
              (
                numbering("1.1", ..counterInt.slice(0, 2))
                  + " "
                  + before.last().body
              )
            })
            #h(1fr)
            #page_number
          ]
        }
      } else {
        let before = query(selector(heading.where(level: 1)).before(here()))
        let counterInt = counter(heading).at(here()).first()
        if before != () and counterInt > 0 {
          box(width: 100%, inset: (bottom: 5pt), stroke: (bottom: 0.5pt))[
            #page_number
            #h(1fr)
            #text(weight: "bold", if appendix != none {
              numbering("A.1", counterInt) + ". " + before.last().body
            } else {
              (
                before.last().supplement
                  + " "
                  + str(counterInt)
                  + ". "
                  + before.last().body
              )
            })
          ]
        }
      }
    },
  )

  show terms: set par(first-line-indent: 0em)

  let main-color = blue
  show cite: it => {
    show regex("[\w\W]"): set text(main-color)
    it
  }

  let fakepar = context {
    let b = par(box())
    b
    v(-measure(b + b).height)
  }

  // 解决首行缩进所带来的代码块问题
  // https://stormckey.github.io/PeiPei/typst
  show math.equation.where(block: true): it => it + fakepar
  show heading: it => it + fakepar // 标题后缩进
  show figure: it => it + fakepar // 图表后缩进
  show enum.item: it => it + fakepar
  show enum.item: set block(above: 0.95em, below: 0.95em)
  show list.item: it => it + fakepar // 列表后缩进
  show list.item: set block(above: 0.95em, below: 0.95em)

  show grid: set block(above: 0.95em, below: 0.95em)

  show emph: text.with(font: "LXGW WenKai GB")

  show math.equation: set text(font: (
    "New Computer Modern Math",
    "LXGW WenKai GB",
    // "DejaVu Sans",
    // "Yu Gothic",
  ))
  show figure.where(kind: table): set figure(supplement: "表")
  show figure.where(kind: table): set figure.caption(position: top)
  show table: it => {
    // 表内の文字は少し小さくする
    set text(size: 10pt)
    // justifyだとあまりきれいじゃないので無効化
    set par(justify: false)
    it
  }
  show figure.where(kind: image): set figure(supplement: "图")
  show figure.caption: it => {
    set text(size: 10.5pt)
    set align(center)
    it
  }
  show figure: set block(breakable: true)

  set list(spacing: 0.65em, indent: 0em, marker: (
    text(font: "Helvetica Neue",size: 0.6em, baseline: +0.3em, "➤", fill: luma(0)),
    text(font: "Menlo", size: 1.2em, baseline: -0.1em, "•", fill: luma(0)),
  ))

  set math.equation(numbering: (..num) => context {
    let current-chapter-num = counter(heading).get().at(0)
    numbering("(1.1)", current-chapter-num, ..num)
  })

  set figure(numbering: (..num) => {
    let current-chapter-num = counter(heading).get().at(0)
    numbering("1-1", current-chapter-num, ..num)
  })
  set figure.caption(separator: h(1em))

  set text(
    font: (
      // Englisgh
      // "Menlo",
      (name: "Helvetica", covers: regex("[a-zA-Z0-9’—]")),
      // (name: "Helvetica", covers: "latin-in-cjk"),
      "Segoe UI",
      // Chinese
      "Microsoft YaHei",
      "Source Han Serif SC",
      // Korea
      "SeoulNamsan M",
      "SeoulHangang M",
    ),
    lang: language,
    size: font-size,
    weight: 500,
  ) // region: "cn",

  show raw.where(block: false): {
    box.with(
      fill: rgb("202628"),
      inset: (x: 3pt),
      outset: (y: 4pt),
      radius: 2pt,
    )
  }

  // Blocs de code inline
  show raw.where(block: false): set text(fill: white)

  show raw: text.with(font: "Cascadia Code")

  show ref: it => {
    if it.element == none {
      it
      return
    }

    if it.element.func() == figure {
      // 図表は強調表示する
      set text(weight: "bold")
      it
    } else if it.element.func() == heading and it.element.level == 1 {
      // 見出しは見出しのナンバリングをそのまま使用
      link(
        it.element.location(),
        numbering(
          heading.numbering,
          ..counter(
            heading,
          ).at(it.element.location()),
        ).trim(),
      )
    } else {
      it
    }
  }

  set heading(hanging-indent: 0pt, numbering: (..nums) => {
    let vals = nums.pos()
    let pattern = if vals.len() == 1 { "1." } else if vals.len() <= 4 {
      "1.1"
    }
    if pattern != none { numbering(pattern, ..nums) }
  })

  // show heading.where(level: 1): set heading(supplement: "Chapter")
  set heading(numbering: (..args) => {
    let nums = args.pos()
    if nums.len() == 1 {
      set text(baseline: 7pt)
      numbering("第1章  ", ..nums)
    } else {
      numbering("1.1.1 ", ..nums)
    }
  })

  // 見出しのナンバリングとフォントを設定
  show heading: set text(
    font: ("Menlo", "Microsoft YaHei"),
    baseline: 7pt,
    weight: "bold",
  )

  let title1 = 1.8em
  let title2 = 1.5em
  let title3 = 1.3em
  let heading-image = state("heading-image", none)
  let heading-text = state("heading-text", none)
  let part-change = state("part-change", false)
  let main-color-state = state("main-color-state", none)
  let main-color = rgb("#F36619")

  show heading.where(level: 1): set heading(supplement: supplement-chapter)

  show heading: it => {
    set text(size: font-size)
    if it.level == 1 {
      pagebreak(to: "odd")
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(math.equation).update(0)
      context {
        let img = heading-image.at(here())
        if img != none {
          let img-h = 9cm
          place(top, dy: -page.margin.top, dx: -page.margin.left, block(
            width: page.width,
            {
              image-index
              // image(
              //   "./orange1.jpg",
              //   width: 100%,
              //   height: img-h,
              //   fit: "cover",
              // )
              place(bottom, {
                block(
                  fill: luma(81.57%, 91.4%).transparentize(10%),
                  stroke: 0pt,
                  height: 1.5cm,
                  // inset: (left: 2em, rest: 1.6em),
                  inset: (left: page.margin.left),
                  width: 100%,
                  align(left + horizon, text(
                    size: title1,
                    font: "Microsoft YaHei",
                    it,
                  )),
                )
              })
            },
          ))

          // set image(width: 21cm, height: 9.4cm)
          // place(move(dx: -2.2cm, dy: -1.8cm, img))
          //
          // let img-h = 9cm
          // place(move(dx: -2.2cm, dy: -1.8cm, block(
          //   // width: 21cm,
          //   width: page.width,
          //   height: 9cm,
          //   align(right + bottom, pad(bottom: 1.2cm, block(
          //     // width: 86%,
          //     width: 100%,
          //     height: 1.5cm,
          //     // stroke: (
          //     //   right: none,
          //     //   rest: 2pt + main-color,
          //     // ),
          //     stroke: 0pt,
          //     inset: (left: 2em, rest: 1.6em),
          //     // fill: rgb("#FFFFFFAA"),
          //     fill: luma(81.57%, 91.4%).transparentize(10%),
          //     // radius: (
          //     //   right: 0pt,
          //     //   left: 10pt,
          //     // ),
          //     align(left + horizon, text(size: title1, it)),
          //   ))),
          // )))
          v(8.4cm)
        } else {
          move(dx: 1.8cm, dy: -0.5cm, align(right + top, block(
            width: 100% + 3cm,
            stroke: (
              right: none,
              rest: 2pt + main-color,
            ),
            inset: (left: 2em, rest: 1.6em),
            fill: white,
            radius: (
              right: 0pt,
              left: 10pt,
            ),
            align(left, text(size: title1, it)),
          )))
          v(1.5cm, weak: true)
        }
      }
      part-change.update(x => false)
    } else if it.level == 2 or it.level == 3 or it.level == 4 {
      let size
      let space
      let color = main-color
      if it.level == 2 {
        size = title2
        space = 1em
      } else if it.level == 3 {
        size = title3
        space = 0.7em
      } else {
        size = title4
        space = 0.7em
        color = black
      }
      set text(size: size)
      let number = if it.numbering != none {
        set text(fill: main-color) if it.level < 4
        let num = counter(heading).display(it.numbering)
        let width = measure(num).width
        let gap = 7mm
        place(dx: -width - gap, num)
      }
      block(number + it.body)
      v(space, weak: true)
    } else {
      it
    }
  }

  // 脚注のスタイルを設定
  set footnote(numbering: sym.dagger + "1")
  set footnote.entry(separator: line(length: 100%, stroke: 0.5pt))
  show footnote: it => {
    set text(size: 10.5pt)
    it
  }
  show footnote.entry: it => {
    set text(size: 6pt)

    grid(
      columns: (auto, 1fr),
      gutter: 1em,
      numbering(sym.dagger + "1", ..counter(footnote).at(it.note.location())),
      it.note.body,
    )
  }

  // Configure headings
  let font_size = 10pt
  let top_margin = 0pt
  let bottom_margin = 0pt

  // Configure h1
  if is-thesis {
    font_size = 21pt
    top_margin = 25pt
    bottom_margin = 45pt
  } else {
    font_size = 18pt
    top_margin = 30pt
    bottom_margin = 25pt
  }

  show heading.where(level: 1): set block(
    above: top_margin,
    below: bottom_margin,
  )
  // show heading.where(level: 1): set text(size: font_size, weight: 600)
  show heading.where(level: 1): it => {
    if is-thesis {
      pagebreak(weak: true)
      v(THESIS_HEADING_EXTRA_TOP_MARGIN)
      it
      par(leading: 122em)[#text(size: 0.0em)[#h(0.0em)]]
    } else {
      it
      par(leading: 1.2em)[#text(size: 0.0em)[#h(0.0em)]]
    }
  }

  // Configure h2
  if is-thesis {
    font_size = 14pt
    top_margin = 30pt
    bottom_margin = 25pt
  } else {
    font_size = 13pt
    top_margin = 30pt
    bottom_margin = 25pt
  }

  // 節の見出し
  show heading.where(level: 2): it => {
    set text(size: 11pt)
    set par(leading: 0.4em)
    set block(above: top_margin, below: 0pt)

    align(left)[#it]
    par(leading: 1.2em)[#text(size: 0.0em)[#h(0.0em)]]
  }

  // Configure h3
  if is-thesis {
    font_size = 11pt
    top_margin = 20pt
    bottom_margin = 15pt
  } else {
    font_size = 11pt
    top_margin = 20pt
    bottom_margin = 15pt
  }

  show heading.where(level: 3): set block(
    above: top_margin,
    below: bottom_margin,
  )
  show heading.where(level: 3): set text(size: 10.5pt)

  // Abstract
  if abstract-zh != none or abstract-en != none {
    import "pages/abstract.typ": abstract_page
    if (language == "en") {
      abstract_page(
        language: "en",
        author: author,
        title: title-en,
        keywords: keywords-en,
        abstract: abstract-en,
      )
    }
    abstract_page(
      language: "zh",
      author: author,
      title: title-zh,
      keywords: keywords-zh,
      abstract: abstract-zh,
    )
  }

  set underline(offset: 3pt)

  // Title page.
  page(margin: 0cm, header: none)[
    #set text(fill: black)
    #language-state.update(x => lang)
    #main-color-state.update(x => main-color)
    #part-style-state.update(x => part-style)
    #supplement-part-state.update(x => supplement-part)
    //#place(top, image("images/background2.jpg", width: 100%, height: 50%))
    #if cover != none {
      set image(width: 100%, height: 100%)
      place(bottom, cover)
    }
    #if logo != none {
      set image(width: 20em)
      place(top + center, pad(top: 3cm, logo))
    }
    #align(center + horizon, block(
      width: 100%,
      fill: main-color.lighten(70%),
      height: 7.5cm,
      pad(x: 2cm, y: 1cm)[
        #par(leading: 0.4em)[
          #text(size: title-main-1, weight: "black", title)
        ]
        #v(1cm, weak: true)
        #text(size: title-main-2, subtitle)
        #v(1cm, weak: true)
        #text(size: title-main-3, weight: "bold", author)
      ],
    ))
  ]
  if (copyright != none) {
    set text(size: 10pt)
    show link: it => [
      // #set text(fill: main-color)
      #set text(fill: rgb(0, 0, 255))
      #it
    ]
    set par(spacing: 2em)
    align(bottom, copyright)
  }

  // List of Figures
  // if is-thesis {
  //   include "pages/list_of_figures.typ"
  // }

  // List of Tables
  // if is-thesis {
  //   include "pages/list_of_tables.typ"
  // }

  // Listings
  if is-thesis {
    include "pages/listings.typ"
  }

  import "pages/outline.typ": *

  heading-image.update(x => image-index)

  my-outline(
    appendix-state,
    appendix-state-hide-parent,
    part-state,
    part-location,
    part-change,
    part-counter,
    main-color,
    textSize1: outline-part,
    textSize2: outline-heading1,
    textSize3: outline-heading2,
    textSize4: outline-heading3,
  )

  my-outline-sec(
    text(baseline: 1pt, font: "Microsoft YaHei")[#list-of-figure-title],
    figure.where(kind: image),
    outline-heading3,
  )

  my-outline-sec(
    text(baseline: 1pt, font: "Microsoft YaHei")[#list-of-table-title],
    figure.where(kind: table),
    outline-heading3,
  )

  // Main body.
  set par(
    // leading: 0.6em,
    justify: true,
    // spacing: 1.5em,
    spacing: 0.65em,
    // first-line-indent: (amount: 2em, all: false),
    first-line-indent: 2em,
  )

  // 超链接设置颜色和下划线
  // show link: {
  //   underline.with(stroke: rgb("#0074d9"), offset: 3pt)
  // }
  show link: set text(fill: main-color)

  // set block(spacing: 1.2em)

  body

  // Declaration of independent processing
  counter(heading).update(0)
  // show heading.where(level: 1): it => {
  // set align(bottom + center)
  // it.body
  // }
  if include-declaration-of-independent-processing {
    pagebreak(weak: true)
    import "pages/declaration_of_independent_processing.typ": (
      declaration_of_independent_processing,
    )
    declaration_of_independent_processing()
  }
}
