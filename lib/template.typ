#let template(
  is-thesis: true,
  is-master-thesis: false,
  is-bachelor-thesis: true,
  is-report: false,
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

  import "@preview/cuti:0.3.0": show-cn-fakebold
  show: show-cn-fakebold

  // Set the document's basic properties.
  set document(author: author, title: title, date: submission-date)
  set page(
    paper: "a4",
    margin: (
      left: 15mm,
      right: 15mm,
      top: PAGE_MARGIN_TOP,
      bottom: 15mm,
    ),
    // numbering: "1",
    number-align: right,
    binding: left,
    header-ascent: 24pt,
    header: context {
      // Before
      let selector_before = selector(heading.where(level: 1)).before(here())
      let level_before = int(counter(selector_before).display())
      let headings_before = query(selector_before)

      if headings_before.len() == 0 {
        return
      }

      // After
      let selector_after = selector(heading.where(level: 1)).after(here())
      let level_after = level_before + 1
      let headings_after = query(selector_after)

      if headings_after.len() == 0 {
        return
      }

      // Get headings
      let heading_before = headings_before.last()
      let heading_after = headings_after.first()

      // Decide on heading
      let heading = heading_before
      let level = level_before

      if heading_after.location().page() == here().page() {
        if (
          heading_after.location().position().y
            == (THESIS_HEADING_EXTRA_TOP_MARGIN + PAGE_MARGIN_TOP)
            or heading_after.location().position().y == PAGE_MARGIN_TOP
        ) {
          // Next header is first element of page
          return
        } else {
          heading = heading_after
          level = level_after
        }
      }

      set text(size: 11pt)
      grid(
        rows: 2,
        gutter: 5pt,
        if heading.numbering != none {
          emph(str(level) + " " + heading.body)
        } else {
          emph(heading.body)
        },
        line(length: 100%, stroke: 0.7pt),
      )
    },
  )

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
  show list.item: it => it + fakepar // 列表后缩进
  show math.equation: set text(
    font: (
      "New Computer Modern Math",
      "DejaVu Sans",
      "Yu Gothic",
    ),
  )
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
    set text(size: 8pt)
    set align(center)
    it
  }

  let accent-color = eastern
  let ghost-color = rgb(50%, 50%, 50%, 50%)
  set list(
    marker: (
      text(
        font: "Menlo",
        size: 1.5em,
        baseline: -0.2em,
        "✴",
        fill: accent-color,
      ),
      text(size: 0.6em, baseline: +0.2em, "➤", fill: ghost-color),
    ),
  )

  set math.equation(
    numbering: (..num) => context {
      let current-chapter-num = counter(heading).get().at(0)
      numbering("(1.1)", current-chapter-num, ..num)
    },
  )

  set figure(
    numbering: (..num) => {
      let current-chapter-num = counter(heading).get().at(0)
      numbering("1-1", current-chapter-num, ..num)
    },
  )
  set figure.caption(separator: h(1em))

  set par(
    leading: 0.6em,
    justify: true,
    spacing: 1.5em,
    first-line-indent: (amount: 2em, all: true),
  )
  set text(
    font: ("Liberation Sans", "New Computer Modern", "SimSun"),
    lang: language,
    size: 11pt,
  ) // region: "cn",
  set heading(numbering: "1.1")

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
          ..counter(heading).at(it.element.location()),
        ).trim(),
      )
    } else {
      it
    }
  }

  // 見出しのナンバリングとフォントを設定
  show heading: set text(weight: "bold")

  // 章の見出し
  show heading.where(level: 1): it => {
    // 図表番号をリセット
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    // 脚注番号をリセット
    counter(footnote).update(0)

    // 右寄せにする
    set align(right)
    set text(size: 20pt, weight: "bold")

    v(3%)
    // 章番号を表示
    if counter(heading).at(it.location()).at(0) != 0 {
      text(
        fill: luma(100),
        numbering(
          heading.numbering,
          ..counter(heading).at(it.location()),
        ).trim(),
      )
    } else {
      // ナンバリングがない場合はダミーを入れる
      text("")
    }
    v(-12pt)
    it.body
    v(7%)
  }
  set heading(
    numbering: (..args) => {
      let nums = args.pos()
      if nums.len() == 1 {
        numbering("第1章  ", ..nums)
      } else {
        numbering("1.1.1 ", ..nums)
      }
    },
  )

  // 超链接设置颜色和下划线
  show link: {
    underline.with(stroke: rgb("#0074d9"), offset: 3pt)
  }
  show link: set text(blue)

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

  // 图标设置
  let icon(path) = box(
    baseline: 0.125em,
    height: 0.8em,
    width: 1.0em,
    align(center + horizon, image(path)),
  )

  let faGithub = icon("icons/fa-github.svg")
  let faLinux = icon("icons/fa-linux.svg")
  let faGmail = icon("icons/fa-gmail.svg")
  let faQQ = icon("icons/fa-qq.svg")
  let faWechat = icon("icons/fa-weixin.svg")

  show "Github": githubUrl => box[
    // #box(faGithub) #githubUrl
    #box(faGithub)
  ]

  show "Linux": name => box[
    // #box(faLinux) #name
    #box(faLinux)
  ]

  show "Gmail": name => box[
    // #box(faGmail) #name
    #box(faGmail)
  ]

  show "QQ": name => box[
    #box(faQQ)
  ]

  show "Wechat": name => box[
    #box(faWechat)
  ]

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
    } else {
      it
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
    set block(
      above: top_margin,
      below: bottom_margin,
    )

    align(left)[#it]
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
  show heading.where(level: 3): set text(size: 11pt)

  // Cover
  import "pages/cover.typ": cover_page
  cover_page(
    is-thesis: is-thesis,
    is-master-thesis: is-master-thesis,
    is-bachelor-thesis: is-bachelor-thesis,
    is-report: is-report,

    title: title,
    author: author,
    faculty: faculty,
    department: department,
    study-course: study-course,
    supervisors: supervisors,
    submission-date: submission-date,
    date: date,
  )

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

  // Table of contents.
  import "pages/outline.typ": outline_page
  outline_page()

  // List of Figures
  if is-thesis {
    include "pages/list_of_figures.typ"
  }

  // List of Tables
  if is-thesis {
    include "pages/list_of_tables.typ"
  }

  // Listings
  if is-thesis {
    include "pages/listings.typ"
  }

  // Reset page numbering and set it to numbers
  set page(numbering: "1 / 1")
  counter(page).update(1)

  // Main body.
  set par(justify: true)

  body

  // Declaration of independent processing
  counter(heading).update(0)
  show heading.where(level: 1): it => {
    set align(center)
    it.body
  }
  if include-declaration-of-independent-processing {
    pagebreak(weak: true)
    import "pages/declaration_of_independent_processing.typ": (
      declaration_of_independent_processing,
    )
    declaration_of_independent_processing()
  }
}
