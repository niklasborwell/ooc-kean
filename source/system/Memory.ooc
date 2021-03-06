/* This file is part of magic-sdk, an sdk for the open source programming language magic.
 *
 * Copyright (C) 2016 magic-lang
 *
 * This software may be modified and distributed under the terms
 * of the MIT license.  See the LICENSE file for details.
 */

include string // Memory routines in C are actually in string.h
version(windows) { include malloc }
else { include alloca }

// Note: Original SDK ooc code assumes allocated memory is zeroed (calloc)
// Consider using Buffer instead of calling these functions directly
// note: sizeof is intentionally not here. Use `Int size` instead of `sizeof(Int)`
malloc: extern func (SizeT) -> Pointer
calloc: extern func (SizeT, SizeT) -> Pointer
realloc: extern func (Pointer, SizeT) -> Pointer
memset: extern func (Pointer, Int, SizeT) -> Pointer
memcmp: extern func (Pointer, Pointer, SizeT) -> Int
memmove: extern func (Pointer, Pointer, SizeT)
memcpy: extern func (Pointer, Pointer, SizeT)
memfree: extern (free) func (Pointer)
alloca: extern func (SizeT) -> Pointer

// Used for executing any/all cleanup (free~all) functions before program exit
GlobalCleanup: class {
	_functionPointers: static Stack<Closure> = null
	init: func
	register: static func (pointer: Func) {
		if (This _functionPointers == null)
			This _functionPointers = Stack<Closure> new()
		This _functionPointers push(pointer as Closure)
	}
	run: static func {
		if (This _functionPointers != null) {
			while (!This _functionPointers isEmpty) {
				next := This _functionPointers pop()
				(next as Func)()
				(next) free()
			}
			This _functionPointers free()
			This _functionPointers = null
		}
	}
	clear: static func {
		if (This _functionPointers != null) {
			This _functionPointers free()
			This _functionPointers = null
		}
	}
}
