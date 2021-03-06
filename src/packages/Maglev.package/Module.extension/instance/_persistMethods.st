*maglev-runtime
_persistMethods
  | envId tmd pmd |
  (self == Module) ifTrue: [ ^ nil ].
  envId := 1 .
  tmd := self transientMethodDictForStoreEnv: envId .
  pmd := self persistentMethodDictForStoreEnv: envId .
  "copying methods in persistent method dict"
  tmd keysAndValuesDo: [:key :value |
    pmd at: key put: value .
  ].