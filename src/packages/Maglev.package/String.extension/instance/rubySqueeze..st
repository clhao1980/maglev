*maglev-runtime
rubySqueeze: templates
 "A Ruby primitive.
  return a copy of receiver , converting each repeating character sequence per templates
  to a single character."
| res n dest prev ch sz charset |
charset := BitSet forTemplates: templates env: 1"__callerEnvId" .
sz := self size .
sz > 1 ifTrue:[
  res := self species new: sz // 2 .
  prev := -1 .
  n := 1 .
  dest := 0 .
  [ n <= sz and:[(ch := self codePointAt: n) ~~ prev]] whileTrue:[
    dest := dest + 1 .
    res codePointAt: dest put: ch .
    n := n + 1 .
    prev := ch
  ].
  [ n <= sz ] whileTrue:[ 
    ((ch := self codePointAt: n) == prev and:[ (charset at: prev) == 1]) ifTrue:[
      n := n + 1 .
      [ n <= sz and:[ (ch := self codePointAt: n) == prev ]] whileTrue:[
    n := n + 1
      ].
      n <= sz ifTrue:[
        dest := dest + 1 .
        res codePointAt: dest put: ch .
      ] 
    ] ifFalse:[
      dest := dest + 1 .
      res codePointAt: dest put: ch .
    ].
    n := n + 1 .
    prev := ch .
  ].
  dest < sz ifTrue:[ res size: dest ].
] ifFalse:[
  res := self copy .
].
^ res

