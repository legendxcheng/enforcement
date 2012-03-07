package Fighters
{
	/**
	 *	@author Xcheng
	 *	the mother class for all types of characters
	 */
	public class Fighter
	{
		static public const WARRIOR:int = 0;	
		static public const WIZARD:int = 3;
		static public const ARCHER:int = 1;
		static public const THIEF:int = 2;
		static public const NONE:int = 4;
		
		static public const WARRIOR_HP:int = 10;
		static public const WARRIOR_ATK:int = 5;
		static public const WARRIOR_DEF:int = 3;
		
		static public const WIZARD_HP:int = 12;
		static public const WIZARD_ATK:int = 6;
		static public const WIZARD_DEF:int = 2;
		
		static public const THIEF_HP:int = 10;
		static public const THIEF_ATK:int = 4;
		static public const THIEF_DEF:int = 6;
		
		static public const ARCHER_HP:int = 10;
		static public const ARCHER_ATK:int = 4;
		static public const ARCHER_DEF:int = 3;
		
		public var board:Board;//reference to board
		public var bead:Boolean;
		public var logstr:String;
		public var logexstr:String;
		
		//original attributes
		public var _hp:int;//blood volume
		public var _atk:int;//attack
		public var _def:int;//defend
		public var _type:int;//0 1 2 3 4

		//flag for atk and def
		public var atked:Boolean;
		public var defed:Boolean;
		
		//current attributes
		public var hp:int;
		public var atk:int;
		public var aatk:int;//extra atk point when attack
		public var def:int;
		public var ddef:int;//extra def point when defend
		
		public var curSp:int;//current dice value
		public var moveSp:int;//sp used by movement		
		public var atkSp:int;// for Archer, sp used by attack
		//if true, atk plus def minus
		//if false, atk minus, def plus
		public var atkdefFlag:Boolean;
		
		public var moveRangeSet:Boolean;
		public var moveRange:Array;
		public var moved:Boolean;//has moved this turn
		//skill point
		public var sp:int;
		
		//coordinates in board
		public var x:int;
		public var y:int;
		public var prex:int;//previous x
		public var prey:int;//previous y
		
		//defend or not
		public var isDefend:Boolean;
		
		//dead or not
		public var dead:Boolean;
		
		//possible moves
		public var moves:Array = new Array();
		
		public function setID(iii:int):void
		{
			switch (iii)
			{
				case 1:
					this.x = 0;
					this.y = 0;
					break;
				case 2:
					this.x = Enforcement.board.len - 1;
					this.y = 0;
					break;
				case 3:
					this.x = 0;
					this.y = Enforcement.board.len - 1;
					break;
				case 4:
					this.x = Enforcement.board.len - 1;
					this.y = Enforcement.board.len - 1;
					break;
			}
			updateAttributes();
		}
		
		public function Fighter()
		{
			//board referrence
			atkdefFlag = true;
			logexstr = "";
			
			
		}
		
		/**
		 * call each round
		 * init
		 */
		public function roundInit():void
		{
			prex = this.x;
			prey = this.y;
			moved = false;
			ddef = 0;
			aatk = 0;
			this.curSp = 0;
			this.updateAttributes();
			atked = false;
			defed = false;
			atkSp = 0;
			this.moveRangeSet = false; 
			logstr = "";
			logexstr = "";
		}
		
		public function skill():void//super art
		{
			
		}
		
		/**
		 * set attributes except for x and y to original values
		 */ 
		public function init():void
		{
			hp = _hp;
			atk = _atk;
			def = _def;
			dead = false;
			atkdefFlag = true;
			sp = 0;
			atkSp = 0;
		}
		
		/**
		 * update attributes when condition changes
		 */
		public function updateAttributes():void
		{
			//update def and atk
			if (atkdefFlag)
			{
				atk = _atk + Enforcement.board.val[x][y] + aatk;
				def = _def - Enforcement.board.val[x][y] + ddef;
			}
			else
			{
				atk = _atk - Enforcement.board.val[x][y] + aatk;
				def = _def + Enforcement.board.val[x][y] + ddef;
			}
			if (atk < 0)
				atk = 0;
			if (def < 0)
				def = 0;
		}
		
		/**
		 * move to the given coordinate
		 */
		public function move(x:int, y:int):void
		{

			this.x = x;
			this.y = y;
			
			updateAttributes();
			
			
		}
		
		/**
		 * attack the opponent at the given coordinate
		 */
		public function attck(tp:Player):void
		{
			
		}
		
		/**
		 * set defend
		 */
		public function defend():void
		{
			defed = true;
			logexstr = "    Defend.";
		}
		
		/**
		 * calc possible moves
		 */
		public function calcPossibleMoves():Array
		{
			if (this.moveRangeSet)
				return moveRange;
	
			moveRange = new Array();
			
			for (var j:int = Enforcement.board.up; j <= Enforcement.board.bottom; ++j)
			{
				for (var i:int = Enforcement.board.left; i <= Enforcement.board.right; ++i)
				{
					if (Math.abs(i - this.prex) + Math.abs(j - this.prey) <= this.curSp / 2 + 1)
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
		 * operations after move
		 */
		public function moveEnd():void
		{
			moved = true;
			
			sp += curSp - moveSp - atkSp - aatk - ddef;
			curSp = 0;
			moveSp = 0;
			
			//add log to logwin
			logstr = "    Player " + Enforcement.curPlayer + ": Move to (" + this.x + ", " + this.y + ").";
			Enforcement.playState.logwin.log.push("Round " + Enforcement.round + ":\n" + this.logstr + "\n" + this.logexstr);
			Enforcement.playState.logwin.updateContent();
		}
		
		/**
		 * return possible poistions for attack
		 */
		public function atkRange():Array
		{
			return null;
		}
		
		/**
		 * take [damage] damage
		 */
		public function takeDamage(d:int):void
		{
			hp -= d;
			if (hp <= 0)
			{
				hp = 0;
				dead = true;
			}
		}
	}
}