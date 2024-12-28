app [main!] { pf: platform "../basic-cli/platform/main.roc" }

import pf.Dir
import pf.Path
import pf.File

main! = \_args ->
    dir_entries = try Dir.list! "."

    dir_list = (List.map dir_entries Path.display)

    even = 1
    
    foo = List.walk dir_list { file: [], dir: [] } \state, elem ->
        if File.is_file! elem then
            { state & file: List.append state.file elem }
        else
            { state & dir: List.append state.dir elem }

    
    dbg foo
    Ok {}
    
