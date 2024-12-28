app [main!] { pf: platform "../basic-cli/platform/main.roc" }

import pf.Dir
import pf.Path
import pf.File

main! = \_args ->
    dir_entries = try Dir.list! "."

    dir_list = (List.map dir_entries Path.display)

    even = 1
    
    foo = List.walk dir_list { file: [], dir: [] } \state, elem ->
        when File.is_file! elem is
        Result Ok ->
            { state & file: List.append state.file elem }
        Result Err ->
            { state & dir: List.append state.dir elem }

    
    dbg foo
    Ok {}
    
