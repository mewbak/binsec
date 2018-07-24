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

(** Parsing/Serializing DBA from/to DBA piqi data structure *)

(** convert a list of dbainstr to a list DBA in the Piqi format *)
val generate_dbalist :
  Dba_types.Statement.t list -> Dba_piqi.Dba_list.t

(** convert a list of Piqi DBA instr to DBA instructions *)
val parse_dbalist :
  Dba_piqi.Dba_list.t -> Dba_types.Statement.t list
