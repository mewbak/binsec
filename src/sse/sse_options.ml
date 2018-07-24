(**************************************************************************)
(*  This file is part of BINSEC.                                          *)
(*                                                                        *)
(*  Copyright (C) 2016-2018                                               *)
(*    CEA (Commissariat à l'énergie atomique et aux énergies              *)
(*         alternatives)                                                  *)
(*                                                                        *)
(*  you can redistribute it and/or modify it under the terms of the GNU   *)
(*  Lesser General Public License as published by the Free Software       *)
(*  Foundation, version 2.1.                                              *)
(*                                                                        *)
(*  It is distributed in the hope that it will be useful,                 *)
(*  but WITHOUT ANY WARRANTY; without even the implied warranty of        *)
(*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *)
(*  GNU Lesser General Public License for more details.                   *)
(*                                                                        *)
(*  See the GNU Lesser General Public License version 2.1                 *)
(*  for more details (enclosed in the file licenses/LGPLv2.1).            *)
(*                                                                        *)
(**************************************************************************)

include Cli.Make(
struct
  let shortname = "sse"
  let name = "Static Symbolic Execution"
end
)

module MaxDepth = Builder.Integer(
  struct
    let name = "depth"
    let default = 1000
    let doc = "set exploration maximal depth"
  end
  )

module MaxPackDepth = Builder.Integer(
  struct
    let name = "pack-depth"
    let default = 50
    let doc = "maximal depth of merge patterns"
  end
  )

module JumpEnumDepth = Builder.Integer(
  struct
    let name = "jump-enum"
    let default = 3
    let doc = "Set maximum number of jump targets to retrieve for dynamic jumps"
  end
  )

module KeepGoing = Builder.False(
  struct
    let name = "keep-going"
    let doc = "Ignore errors returned by the SMT solver. Default is to abort."
  end
  )


module Randomize = Builder.False(
  struct
    let name = "randomize"
    let doc = "randomize path selection"
  end
  )

module SmtDir = Builder.String_option(
  struct
    let name = "smt-dir"
    let doc = "set directory to cache smt scripts"
  end
  )


module AddressTraceFile = Builder.String_option(
  struct
    let name = "address-trace-file"
    let doc = "set file for adress trace export"
  end
  )

module AvoidAddresses = Builder.Integer_set(
  struct
    let name = "no-explore"
    let doc = "set addresses where sse should stop"
  end
  )


module GoalAddresses = Builder.Integer_set(
  struct
    let name = "explore"
    let doc = "set addresses where sse should try to go"
  end
  )

module LoadSections = Builder.String_set(
  struct
    let name = "load-sections"
    let doc =
      "sections to load in initial memory (may be overridden by -memory)"
  end
  )

module LoadROSections = Builder.False(
  struct
    let name = "load-ro-sections"
    let doc =
      "load the content of all read-only sections (see also -sse-load-sections)"
  end
  )

module MemoryFile = Builder.String(
  struct
    let default = "memory.txt"
    let name = "memory"
    let doc = "set file containing the initial (concrete) memory state"
  end
  )

module NoComment = Builder.False(
  struct
    let name = "no-comment"
    let doc = "Disable comments in generated formulas"
  end
  )


module Timeout =
Builder.Float(
struct
  let name = "timeout"
  let doc = "Sets a timeout for symbolic execution"
  let default = infinity
end)


module Address_counter = struct
  type t  = {
    address : Virtual_address.t;
    counter : int;
    }

  let of_string s =
    match String.split_on_char ':' s with
    | address :: [counter] ->
       { address = Virtual_address.of_string address;
         counter = int_of_string counter; }
    | _ -> assert false

  let decr c = { c with counter = c.counter - 1;}

  let check_and_decr c =
    if c.counter > 0 then Some (decr c)
    else None

end

module Visit_address_counter =
  Builder.Variant_list(
      struct
        include Address_counter
        let name = "visit-until"
        let doc  =
          "Specify a the maximum number of times [n] an address [vaddr] \
           is visited by SE (format: <vaddr>:<n>)"
      end
    )

type search_heuristics =
  | Dfs
  | Bfs
  | Nurs

module Search_heuristics =
  Builder.Variant_choice_assoc(struct
      type t = search_heuristics
      let name = "heuristics"
      let doc = "Use the following search heuristics"
      let default = Dfs
      let assoc_map = [
          "dfs", Dfs;
          "bfs", Bfs;
          "nurs", Nurs
        ]
    end)


module Solver_call_frequency =
  Builder.Integer(
      struct
        let name = "solver-call-frequency"
        let default = 1
        let doc = "Call the solver every <n> times"
      end
    )


module Seed =
  Builder.Integer_option(
      struct
        let name = "seed"
        let doc = "Give a specific seed for random number gqenerators"
      end
)

module Goals =
  Builder.Any(
   struct
     type t = Action.t list
     let name = "goals"
     let doc = "Set SSE goals"
     let default = []
     let to_string _ = "no action"

     let of_string s =
       let lexbuf = Lexing.from_string s in
       Parser.actions Lexer.token lexbuf
   end
  )


module Goal_file =
  Builder.String_option(
   struct
     let name = "goal-file"
     let doc  = "Use file to set sse goals"
   end
    )
