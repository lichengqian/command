package command

import java.util.Map
import com.google.common.collect.Maps

interface ICommand {}

final class Command {
	private new() {}
	
	private static Map<Class, (ICommand)=>void> runners = Maps.newConcurrentMap
	
	def static canExecute(ICommand command) {
		return runners.containsKey(command.class)
	}
	
	def static void exec(ICommand command) {
		val r = runners.get(command.class)
		if (r == null)
			throw new UnsupportedOperationException("Unsupported Command :"+command.toString)
		
		r.apply(command)
	}

	def static <T extends ICommand> void addCommandExecutor(Class<T> c, (T)=>void r) {
		runners.put(c, (r as (ICommand)=>void))
	}
}
