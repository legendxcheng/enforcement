package Fighters
{
	/**
	 * @author Xcheng
	 */
	public class Archer extends Fighter
	{
		public function Archer()
		{
			super();
			_hp = Fighter.ARCHER_HP;
			_atk = Fighter.ARCHER_ATK;
			_def = Fighter.ARCHER_DEF;
			_type = Fighter.ARCHER;
			sp = 0;
			init();
		}
		
		override public function calcPossibleMoves():Array
		{
			if (this.moveRangeSet)
				return moveRange;

			moveRange = new Array();
			
			for (var j:int = Enforcement.board.up; j <= Enforcement.board.bottom; ++j)
			{
				for (var i:int = Enforcement.board.left; i <= Enforcement.board.right; ++i)
				{
					if (Math.abs(i - this.x) + Math.abs(j - this.y) <= this.curSp / 2 + 2)
					{
						moveRange.push(i);
						moveRange.push(j);
					}
				}
			}
			moveRangeSet = true;
			return moveRange;

		}
		
		
		/**
		 * can attack in 4 direction, and the distance is determined by your sp + curSp
		 */
		override public function atkRange():Array
		{
			var ret:Array = new Array();
			var tx:int;
			var ty:int;
			
			tx = this.x;
			for (ty = Enforcement.board.up; ty <= Enforcement.board.bottom; ++ty)
			{
				if (Math.abs(this.x - tx) + Math.abs(this.y - ty) <= (this.sp + this.curSp - this.moveSp) / 2+ 1)
				{
					ret.push(tx);
					ret.push(ty);
				}
			}
			
			ty = this.y;
			for (tx = Enforcement.board.up; tx <= Enforcement.board.bottom; ++tx)
			{
				if (Math.abs(this.x - tx) + Math.abs(this.y - ty) <= (this.sp + this.curSp - this.moveSp) / 2 + 1)
				{
					ret.push(tx);
					ret.push(ty);
				}
			}
			
			return ret;
		}
		
		/**
		 * attack the opponent at the given coordinate
		 */
		override public function attck(tp:Player):void
		{
			var tx:int;
			var ty:int;
			var cx:int;
			var cy:int;
			tx = tp.fighter.x;
			ty = tp.fighter.y;
			cx = this.x;
			cy = this.y;
			
			var damage:int = this.atk - tp.fighter.def;
			if (damage > 0)
			{
				tp.fighter.takeDamage(damage);
				if (tp.fighter.hp == 0)
				{
					--Enforcement.playerNum;
					tp.fighter = null;
				}
			}
			atkSp = 2 * ((Math.abs(cx - tx) + Math.abs(cy - ty)) - 1);
			atked = true;
			if (damage < 0) damage = 0;
			logexstr = "    Attak Player" + tp.id + ", produce " + damage + " damage.\n";
		}
		
		/**
		* move to the given coordinate
		*/
		override public function move(x:int, y:int):void
		{
			
			this.x = x;
			this.y = y;
			this.moveSp = 2 * (Math.abs(x - prex) + Math.abs(y - prey) - 2);
			if (moveSp < 0) moveSp = 0;
			updateAttributes();
		}
		
		/**
		 * update attributes when condition changes
		 */
		override public function updateAttributes():void
		{
			//update def and atk
			if (atkdefFlag)
			{
				atk = _atk + Enforcement.board.val[x][y];
				def = _def - Enforcement.board.val[x][y] + ddef;
			}
			else
			{
				atk = _atk - Enforcement.board.val[x][y];
				def = _def + Enforcement.board.val[x][y] + ddef;
			}
			if (atk < 0)
				atk = 0;
			if (def < 0)
				def = 0;
		}
	}
}