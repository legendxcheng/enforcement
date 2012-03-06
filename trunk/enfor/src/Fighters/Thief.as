package Fighters
{
	/**
	 * @author Xcheng
	 */
	public class Thief extends Fighter
	{
		public function Thief()
		{
			super();
			_hp = Fighter.THIEF_HP;
			_atk = Fighter.THIEF_ATK;
			_def = Fighter.THIEF_DEF;
			_type = Fighter.THIEF;
			sp = 0;
			init();
		}
	}
}