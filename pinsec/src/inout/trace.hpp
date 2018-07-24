/**************************************************************************/
/*  This file is part of BINSEC.                                          */
/*                                                                        */
/*  Copyright (C) 2016-2018                                               */
/*    VERIMAG                                                             */
/*    CEA (Commissariat à l'énergie atomique et aux énergies              */
/*         alternatives)                                                  */
/*                                                                        */
/*  you can redistribute it and/or modify it under the terms of the GNU   */
/*  Lesser General Public License as published by the Free Software       */
/*  Foundation, version 2.1.                                              */
/*                                                                        */
/*  It is distributed in the hope that it will be useful,                 */
/*  but WITHOUT ANY WARRANTY; without even the implied warranty of        */
/*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         */
/*  GNU Lesser General Public License for more details.                   */
/*                                                                        */
/*  See the GNU Lesser General Public License version 2.1                 */
/*  for more details (enclosed in the file licenses/LGPLv2.1).            */
/**************************************************************************/

#include "../types/types.hpp"

//Add the given infos in the current chunk
void add_concrete_infos_trace(instruction_infos_t infos, bool exit_on_maxlength);

//Add the number as a new wave number
void add_metadata_wave(int wave_number);

//Initialize the trace file
void initialize_trace_file(const std::string filename, int chunk_size, int maxlength);

//Close the trace file and flush all the pending instructions
void finalize_trace_file();

//Flush the current chunk in the stream
void flush_current_chunk();

//Set the given register_value_t to the appropriate value
void set_register_value_t(common::register_value_t* addr, UINT size, ADDRINT value);

//Convert an register_value_t to ADDRINT (if possible)
ADDRINT register_value_t_to_addrint(const common::register_value_t addr);
