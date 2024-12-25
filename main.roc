app [main!] { pf: platform "../basic-cli/platform/main.roc" }

import pf.Stdout
import pf.Cmd

main! = \_args ->

    try output_example! {}
    Ok {}

# Run "env" with verbose option, clear all environment variables, and pass in
output_example! : {} => Result {} _
output_example! = \{} ->

    output =
        Cmd.new "ls"
        |> Cmd.arg "-l"
        |> Cmd.output!

    msg = Str.fromUtf8 output.stdout |> Result.withDefault "Failed to decode stdout"

    Stdout.write! msg




