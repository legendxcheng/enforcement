package Fighters
{
	/**
	 * @author Xcheng
	 */
	public class Wizard extends Fighter
	{
		public function Wizard()
		{
			super();
			_hp = Fighter.WIZARD_HP;
			_atk = Fighter.WIZARD_ATK;
			_def = Fighter.WIZARD_DEF;
			_type = Fighter.WIZARD;
			sp = 0;
			init();
		}
		

		
		/**
		 * can attack every position within 2 steps from the current position
		 */
		override public function atkRange():Array
		{
			var ret:Array = new Array();
			var tx:int;
			var ty:int;
			
			for (tx = Enforcement.board.left; tx <= Enforcement.board.right; ++tx)
			{
				for (ty = Enforcement.board.up; ty <= Enforcement.board.bottom; ++ty)
				{
					if (Math.abs(this.x - tx) + Math.abs(this.y - ty) <= 2)
					{
						ret.push(tx);
						ret.push(ty);
					}
				}
			}
			
			return ret;
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
			
			atked = true;
			
			var damage:int = this.atk - tp.fighter.def;
			if (damage > 0)
			{
				tp.fighter.takeDamage(damage);
				if (tp.fighter.hp == 0)
				{
					tp.fighter = null;
					--Enforcement.playerNum;
				}
					
			}
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
			this.moveSp = 2 * (Math.abs(x - prex) + Math.abs(y - prey) - 1);
			if (moveSp < 0) moveSp = 0;
			updateAttributes();
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
					if (Math.abs(i - this.x) + Math.abs(j - this.y) <= (this.sp + this.curSp) / 2 + 1)
					{
						moveRange.push(i);
						moveRange.push(j);
					}
				}
			}
			moveRangeSet = true;
			return moveRange;
		}
	}
}