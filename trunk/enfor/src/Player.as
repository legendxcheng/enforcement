package
{
	import Agents.*;
	
	import Fighters.*;

	/**
	 * @author Xcheng
	 */
	public class Player
	{
		public var id:int;//player id
		public var pos:int;//position in the board 4 kinds lu lb ru rb
		public var available:Boolean;//whether this player is set available.
		public var agent:Agent;//if null, it is human-controlled, else it is AI-controlled
		
		public var fighter:Fighter;
		
		public function Player(idd:int, agentType:int, type:int, pos:int)
		{
			id = idd;
			pos = pos;
			if (agentType == 0)//human
			{
				agent = null;
				pos = pos;
				switch (type)
				{
					case Fighter.ARCHER:
						fighter = new Archer();
						fighter.setID(pos);
						break;
					case Fighter.WIZARD:
						fighter = new Wizard();
						fighter.setID(pos);
						break;
					case Fighter.THIEF:
						fighter = new Thief();
						fighter.setID(pos);
						break;
					case  Fighter.WARRIOR:
						fighter = new Warrior();
						fighter.setID(pos);
						break;
					case Fighter.NONE:
						fighter = null;
				}
				
			}
			else
			{
				//TODO
			}
		}
	}
}