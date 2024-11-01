app [main] { io: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br" }

import io.Stdout
import io.Stderr
import io.Arg
import io.File

main =
  Arg.list! {}
  |> List.get 1
  |> Result.withDefault "/dev/stdin"
  |> File.readUtf8
  |> Task.await (\content -> Stdout.line content)
  |> Task.onErr (\err -> when err is
    FileReadErr _ _ -> Stderr.line "error: cannot read file"
    FileReadUtf8Err _ _ -> Stderr.line "error: invalid UTF-8"
    StdoutErr _ -> Stderr.line "TODO"
  )

