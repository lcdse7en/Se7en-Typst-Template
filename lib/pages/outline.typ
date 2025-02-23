#let outline_page() = {
  // TODO Needed, because context creates empty pages with wrong numbering
  set page(numbering: "i")

  set outline.entry(
    fill: grid(
      columns: 2,
      gutter: 0pt,
      repeat[~.], h(11pt),
    ),
  )

  show outline.entry.where(level: 1): set outline.entry(fill: none)
  show outline.entry.where(level: 1): set text(weight: "bold")
  show outline.entry.where(level: 1): set block(above: 16pt)

  outline(
    depth: 3,
    indent: auto,
  )
}

// #let outline_page(
//   depth: 2,
//   title: text(weight: "bold")[
//     #align(
//       center,
//       text(weight: "bold")[目 #h(2em) 录],
//     )
//   ],
// ) = {
//   show outline.entry.where(level: 1): it => {
//     v(12pt, weak: true)
//     show: strong
//     show regex("\d+ "): it => {
//       [第 ] + it + [章]
//       h(1em)
//     }
//     it.body
//     h(1fr)
//     it.page
//   }
//   show outline.entry.where(level: 1): set text(size: 12pt)
//   // show outline.entry.where(level: 2): set text(
//   //   font: ("Palatino Linotype", "SimHei"),
//   //   size: 10.5pt,
//   // )
//   set page(numbering: "I")
//   counter(page).update(1)
//   // outline(title: title, depth: depth, indent: 2em)
//   outline(title: title, depth: depth)
// }
