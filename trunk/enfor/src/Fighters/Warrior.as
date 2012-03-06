package Fighters
{
	/**
	 * @author Xcheng
	 * atk S
	 * def A
	 * spd B
	 * HP 10
	 * Rng B
	 */
	
	public class Warrior extends Fighter
	{
		public function Warrior()
		{
			super();
			_hp = Fighter.WARRIOR_HP;
			_atk = Fighter.WARRIOR_ATK;
			_def = Fighter.WARRIOR_DEF;
			_type = Fighter.WARRIOR;
			sp = 0;
			init();
		}
		
		
		/**
		 * only adjacent places can be picked to attack
		 */
		override public function atkRange():Array
		{
			var ret:Array = new Array();
			var tx:int;
			var ty:int;
			
			//up
			tx = this.x;
			ty = this.y - 1;
			if (ty >= Enforcement.board.up)
			{
				ret.push(tx);
				ret.push(ty);
			}
			
			//down
			ty = this.y + 1;
			if (ty <= Enforcement.board.bottom)
			{
				ret.push(tx);
				ret.push(ty);
			}
			
			//left
			tx = this.x - 1;
			ty = this.y;
			if (tx >= Enforcement.board.left)
			{
				ret.push(tx);
				ret.push(ty);
			}
			
			//right
			tx = this.x + 1;
			if (tx <= Enforcement.board.right)
			{
				ret.push(tx);
				ret.push(ty);
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
			
			atked = true;
			
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
	}
}