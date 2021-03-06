/* This file is part of magic-sdk, an sdk for the open source programming language magic.
 *
 * Copyright (C) 2016 magic-lang
 *
 * This software may be modified and distributed under the terms
 * of the MIT license.  See the LICENSE file for details.
 */

use geometry
use math
import Constraints

ExpectModifier: abstract class {
	parent: This = null
	child: This = null
	init: func ~parent (=parent)
	free: override func {
		if (this child) {
			if (this child parent == this)
				this child parent = null
			this child free()
		}
		if (this parent) {
			if (this parent child == this)
				this parent child = null
			this parent free()
		}
		super()
	}
	verify: func ~parent (value: Object, _child: This = null) -> Bool {
		this child = _child
		this parent != null ? this parent verify(value, this): this test(value)
	}
	test: virtual func (value: Object) -> Bool { this testChild(value) }
	testChild: func (value: Object) -> Bool { this child != null && this child test(value) }
}

EqualModifier: class extends ExpectModifier {
	comparisonType: ComparisonType
	withinType: ComparisonType
	init: func ~parent (parent: ExpectModifier, type := ComparisonType Equal) {
		super(parent)
		this comparisonType = type
		this withinType = type == ComparisonType Equal ? ComparisonType Within : ComparisonType NotWithin
	}
	to: func ~object (correct: Object) -> CompareConstraint {
		f := func (value, c: Object) -> Bool {
			match c {
				case s: String => s == value as String
				case => c == value
			}
		}
		CompareConstraint new(this, correct, f, this comparisonType)
	}
	to: func ~char (correct: Char) -> CompareConstraint {
		f := func (value, c: Cell<Char>) -> Bool { value get() == c get() }
		CompareConstraint new(this, Cell<Char> new(correct), f, this comparisonType)
	}
	to: func ~text (correct: Text) -> CompareConstraint {
		f := func (value, c: Cell<Text>) -> Bool { value get() == c get() }
		CompareConstraint new(this, Cell<Text> new(correct), f, this comparisonType)
	}
	to: func ~boolean (correct: Bool) -> CompareConstraint {
		f := func (value, c: Cell<Bool>) -> Bool { value get() == c get() }
		CompareConstraint new(this, Cell<Bool> new(correct), f, this comparisonType)
	}
	to: func ~int (correct: Int) -> CompareConstraint {
		f := func (value, c: Cell<Int>) -> Bool { value get() == c get() }
		CompareConstraint new(this, Cell<Int> new(correct), f, this comparisonType)
	}
	to: func ~uint (correct: UInt) -> CompareConstraint {
		f := func (value, c: Cell<UInt>) -> Bool { value get() == c get() }
		CompareConstraint new(this, Cell<UInt> new(correct), f, this comparisonType)
	}
	to: func ~uint8 (correct: Byte) -> CompareConstraint {
		f := func (value, c: Cell<Byte>) -> Bool { value get() == c get() }
		CompareConstraint new(this, Cell<Byte> new(correct), f, this comparisonType)
	}
	to: func ~long (correct: Long) -> CompareConstraint {
		f := func (value, c: Cell<Long>) -> Bool { value get() == c get() }
		CompareConstraint new(this, Cell<Long> new(correct), f, this comparisonType)
	}
	to: func ~ulong (correct: ULong) -> CompareConstraint {
		f := func (value, c: Cell<ULong>) -> Bool { value get() == c get() }
		CompareConstraint new(this, Cell<ULong> new(correct), f, this comparisonType)
	}
	to: func ~float (correct: Float) -> CompareWithinConstraint {
		f := func (value, c: Cell<Float>) -> Bool { value get() equals(c get()) }
		CompareWithinConstraint new(this, Cell<Float> new(correct), f, this withinType, Float)
	}
	to: func ~double (correct: Double) -> CompareWithinConstraint {
		f := func (value, c: Cell<Double>) -> Bool { value get() equals(c get()) }
		CompareWithinConstraint new(this, Cell<Double> new(correct), f, this withinType, Double)
	}
	to: func ~ldouble (correct: LDouble) -> CompareWithinConstraint {
		f := func (value, c: Cell<LDouble>) -> Bool { value get() equals(c get()) }
		CompareWithinConstraint new(this, Cell<LDouble> new(correct), f, this withinType, LDouble)
	}
	to: func ~llong (correct: LLong) -> CompareWithinConstraint {
		f := func (value, c: Cell<LLong>) -> Bool { value get() == c get() }
		CompareWithinConstraint new(this, Cell<LLong> new(correct), f, this withinType, LLong)
	}
	to: func ~ullong (correct: ULLong) -> CompareWithinConstraint {
		f := func (value, c: Cell<ULLong>) -> Bool { value get() == c get() }
		CompareWithinConstraint new(this, Cell<ULLong> new(correct), f, this withinType, ULLong)
	}
	to: func ~floatvector2d (correct: FloatVector2D) -> CompareWithinConstraint {
		f := func (value, c: Cell<FloatVector2D>) -> Bool { value get() == c get() }
		CompareWithinConstraint new(this, Cell<FloatVector2D> new(correct), f, this withinType, FloatVector2D)
	}
	to: func ~floatvector3d (correct: FloatVector3D) -> CompareWithinConstraint {
		f := func (value, c: Cell<FloatVector3D>) -> Bool { value get() == c get() }
		CompareWithinConstraint new(this, Cell<FloatVector3D> new(correct), f, this withinType, FloatVector3D)
	}
	to: func ~floatpoint2d (correct: FloatPoint2D) -> CompareWithinConstraint {
		f := func (value, c: Cell<FloatPoint2D>) -> Bool { value get() == c get() }
		CompareWithinConstraint new(this, Cell<FloatPoint2D> new(correct), f, this withinType, FloatPoint2D)
	}
	to: func ~floatpoint3d (correct: FloatPoint3D) -> CompareWithinConstraint {
		f := func (value, c: Cell<FloatPoint3D>) -> Bool { value get() == c get() }
		CompareWithinConstraint new(this, Cell<FloatPoint3D> new(correct), f, this withinType, FloatPoint3D)
	}
	to: func ~quaternion (correct: Quaternion) -> CompareWithinConstraint {
		f := func (value, c: Cell<Quaternion>) -> Bool { value get() == c get() }
		CompareWithinConstraint new(this, Cell<Quaternion> new(correct), f, this withinType, Quaternion)
	}
	to: func ~floateuclidtransform (correct: FloatEuclidTransform) -> CompareWithinConstraint {
		f := func (value, c: Cell<FloatEuclidTransform>) -> Bool { value get() == c get() }
		CompareWithinConstraint new(this, Cell<FloatEuclidTransform> new(correct), f, this withinType, FloatEuclidTransform)
	}
	to: func ~floatrotation3d (correct: FloatRotation3D) -> CompareWithinConstraint {
		f := func (value, c: Cell<FloatRotation3D>) -> Bool { value get() == c get() }
		CompareWithinConstraint new(this, Cell<FloatRotation3D> new(correct), f, this withinType, FloatRotation3D)
	}
	to: func ~floattransform2d (correct: FloatTransform2D) -> CompareWithinConstraint {
		f := func (value, c: Cell<FloatTransform2D>) -> Bool { value get() == c get() }
		CompareWithinConstraint new(this, Cell<FloatTransform2D> new(correct), f, this withinType, FloatTransform2D)
	}
	to: func ~floattransform3d (correct: FloatTransform3D) -> CompareWithinConstraint {
		f := func (value, c: Cell<FloatTransform3D>) -> Bool { value get() == c get() }
		CompareWithinConstraint new(this, Cell<FloatTransform3D> new(correct), f, this withinType, FloatTransform3D)
	}
	to: func ~intvector2d (correct: IntVector2D) -> CompareWithinConstraint {
		f := func (value, c: Cell<IntVector2D>) -> Bool { value get() == c get() }
		CompareWithinConstraint new(this, Cell<IntVector2D> new(correct), f, this withinType, IntVector2D)
	}
	to: func ~intvector3d (correct: IntVector3D) -> CompareWithinConstraint {
		f := func (value, c: Cell<IntVector3D>) -> Bool { value get() == c get() }
		CompareWithinConstraint new(this, Cell<IntVector3D> new(correct), f, this withinType, IntVector3D)
	}
	to: func ~intpoint2d (correct: IntPoint2D) -> CompareWithinConstraint {
		f := func (value, c: Cell<IntPoint2D>) -> Bool { value get() == c get() }
		CompareWithinConstraint new(this, Cell<IntPoint2D> new(correct), f, this withinType, IntPoint2D)
	}
	to: func ~intpoint3d (correct: IntPoint3D) -> CompareWithinConstraint {
		f := func (value, c: Cell<IntPoint3D>) -> Bool { value get() == c get() }
		CompareWithinConstraint new(this, Cell<IntPoint3D> new(correct), f, this withinType, IntPoint3D)
	}
}

LessModifier: class extends ExpectModifier {
	allowEquality: Bool
	typeToPass: ComparisonType
	init: func ~parent (parent: ExpectModifier, allowEquals := false) {
		super(parent)
		this allowEquality = allowEquals
		this typeToPass = allowEquals ? ComparisonType LessOrEqual : ComparisonType LessThan
	}
	than: func ~object (right: Object) -> CompareConstraint {
		f := func (value, c: Object) -> Bool { this allowEquality ? value <= c : value < c }
		CompareConstraint new(this, right, f, this typeToPass)
	}
	than: func ~float (right: Float) -> CompareConstraint {
		f := func (value, c: Cell<Float>) -> Bool { this allowEquality ? value get() lessOrEqual(c get()) : value get() lessThan(c get()) }
		CompareConstraint new(this, Cell<Float> new(right), f, this typeToPass)
	}
	than: func ~double (right: Double) -> CompareConstraint {
		f := func (value, c: Cell<Double>) -> Bool { this allowEquality ? value get() lessOrEqual(c get()) : value get() lessThan(c get()) }
		CompareConstraint new(this, Cell<Double> new(right), f, this typeToPass)
	}
	than: func ~ldouble (right: LDouble) -> CompareConstraint {
		f := func (value, c: Cell<LDouble>) -> Bool { this allowEquality ? value get() lessOrEqual(c get()) : value get() lessThan(c get()) }
		CompareConstraint new(this, Cell<LDouble> new(right), f, this typeToPass)
	}
	than: func ~int (right: Int) -> CompareConstraint {
		f := func (value, c: Cell<Int>) -> Bool { this allowEquality ? value get() <= c get() : value get() < c get() }
		CompareConstraint new(this, Cell<Int> new(right), f, this typeToPass)
	}
	than: func ~uint (right: UInt) -> CompareConstraint {
		f := func (value, c: Cell<UInt>) -> Bool { this allowEquality ? value get() <= c get() : value get() < c get() }
		CompareConstraint new(this, Cell<UInt> new(right), f, this typeToPass)
	}
	than: func ~long (right: Long) -> CompareConstraint {
		f := func (value, c: Cell<Long>) -> Bool { this allowEquality ? value get() <= c get() : value get() < c get() }
		CompareConstraint new(this, Cell<Long> new(right), f, this typeToPass)
	}
	than: func ~ulong (right: ULong) -> CompareConstraint {
		f := func (value, c: Cell<ULong>) -> Bool { this allowEquality ? value get() <= c get() : value get() < c get() }
		CompareConstraint new(this, Cell<ULong> new(right), f, this typeToPass)
	}
	than: func ~llong (right: LLong) -> CompareConstraint {
		f := func (value, c: Cell<LLong>) -> Bool { this allowEquality ? value get() <= c get() : value get() < c get() }
		CompareConstraint new(this, Cell<LLong> new(right), f, this typeToPass)
	}
	than: func ~ullong (right: ULLong) -> CompareConstraint {
		f := func (value, c: Cell<ULLong>) -> Bool { this allowEquality ? value get() <= c get() : value get() < c get() }
		CompareConstraint new(this, Cell<ULLong> new(right), f, this typeToPass)
	}
}

GreaterModifier: class extends ExpectModifier {
	allowEquality: Bool
	typeToPass: ComparisonType
	init: func ~parent (parent: ExpectModifier, allowEquals := false) {
		super(parent)
		this allowEquality = allowEquals
		this typeToPass = allowEquals ? ComparisonType GreaterOrEqual : ComparisonType GreaterThan
	}
	than: func ~object (right: Object) -> CompareConstraint {
		f := func (value, c: Object) -> Bool { this allowEquality ? value >= c : value > c }
		CompareConstraint new(this, right, f, this typeToPass)
	}
	than: func ~float (right: Float) -> CompareConstraint {
		f := func (value, c: Cell<Float>) -> Bool { this allowEquality ? value get() greaterOrEqual(c get()) : value get() greaterThan(c get()) }
		CompareConstraint new(this, Cell<Float> new(right), f, this typeToPass)
	}
	than: func ~double (right: Double) -> CompareConstraint {
		f := func (value, c: Cell<Double>) -> Bool { this allowEquality ? value get() greaterOrEqual(c get()) : value get() greaterThan(c get()) }
		CompareConstraint new(this, Cell<Double> new(right), f, this typeToPass)
	}
	than: func ~ldouble (right: LDouble) -> CompareConstraint {
		f := func (value, c: Cell<LDouble>) -> Bool { this allowEquality ? value get() greaterOrEqual(c get()) : value get() greaterThan(c get()) }
		CompareConstraint new(this, Cell<LDouble> new(right), f, this typeToPass)
	}
	than: func ~int (right: Int) -> CompareConstraint {
		f := func (value, c: Cell<Int>) -> Bool { this allowEquality ? value get() >= c get() : value get() > c get() }
		CompareConstraint new(this, Cell<Int> new(right), f, this typeToPass)
	}
	than: func ~uint (right: UInt) -> CompareConstraint {
		f := func (value, c: Cell<UInt>) -> Bool { this allowEquality ? value get() >= c get() : value get() > c get() }
		CompareConstraint new(this, Cell<UInt> new(right), f, this typeToPass)
	}
	than: func ~long (right: Long) -> CompareConstraint {
		f := func (value, c: Cell<Long>) -> Bool { this allowEquality ? value get() >= c get() : value get() > c get() }
		CompareConstraint new(this, Cell<Long> new(right), f, this typeToPass)
	}
	than: func ~ulong (right: ULong) -> CompareConstraint {
		f := func (value, c: Cell<ULong>) -> Bool { this allowEquality ? value get() >= c get() : value get() > c get() }
		CompareConstraint new(this, Cell<ULong> new(right), f, this typeToPass)
	}
	than: func ~llong (right: LLong) -> CompareConstraint {
		f := func (value, c: Cell<LLong>) -> Bool { this allowEquality ? value get() >= c get() : value get() > c get() }
		CompareConstraint new(this, Cell<LLong> new(right), f, this typeToPass)
	}
	than: func ~ullong (right: ULLong) -> CompareConstraint {
		f := func (value, c: Cell<ULLong>) -> Bool { this allowEquality ? value get() >= c get() : value get() > c get() }
		CompareConstraint new(this, Cell<ULLong> new(right), f, this typeToPass)
	}
}
