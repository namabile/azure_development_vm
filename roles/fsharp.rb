name "fsharp"
description "for machines that require the fsharp language"

run_list "recipe[mono]", "recipe[fsharp]"
