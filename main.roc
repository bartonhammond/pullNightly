app [main!] { pf: platform "../basic-cli/platform/main.roc" }

import pf.Stdout
import pf.Cmd
import pf.Env
import pf.Dir
import pf.Path

main! = \_args ->
    #try getNightlyRelease! {}
    #try extractNightlyRelease! {}

    
    # List the contents of a directory
    cwd_str = Path.display (try Env.cwd! {})
    dir_entries = try Dir.list! cwd_str

    dir_list = (List.map dir_entries Path.display)

    dbg dir_list

    #dir_list.any (\str -> Str.endsWith str ".gz")
    dbg dir_list 

    #try getNightlyFileName! {}
    Ok {}

getNightlyRelease! : {} => Result {} _
getNightlyRelease! = \{} -> Cmd.exec! 
    "curl" ["-OL", "https://github.com/roc-lang/roc/releases/download/nightly/roc_nightly-macos_apple_silicon-latest.tar.gz"]    


extractNightlyRelease! : {} => Result {} _
extractNightlyRelease! = \{} -> Cmd.exec! 
        "tar" ["xf", "roc_nightly-macos_apple_silicon-latest.tar.gz"]
    


# Run "env" with verbose option, clear all environment variables, and pass in
getNightlyFileName! : {} => Result {} _
getNightlyFileName! = \{} ->

    output =
        Cmd.new "ls"
        |> Cmd.output!

    msg = Str.fromUtf8 output.stdout |> Result.withDefault "Failed to decode stdout"

    Stdout.write! msg




