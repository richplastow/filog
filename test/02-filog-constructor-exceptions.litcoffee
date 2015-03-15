Xx.

    test.section "Filog constructor exceptions"

    test.throws [

      "new Filog 1"
      "'opt' is type 'number', not 'string|object'"
      -> new Filog 1

    ]
