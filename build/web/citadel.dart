library citadel;

import 'dart:core';
import 'dart:html';
import 'dart:math';
import 'dart:convert';
import 'dart:async';
import 'package:crypto/crypto.dart';

part 'game.dart';
part 'calendar.dart';
part 'player.dart';
part 'character.dart';
part 'job.dart';
part 'biome.dart';
part 'world.dart';

void main()
{
	new Game();

//	Element dropdown = new Element.nav();
//	dropdown.attributes['id'] = 'dropdown';
//	dropdown.style.float = 'Left';
//
//	dropdown.appendHtml("Jobs" + '<br');
//
//	List<String> job_list = ['rover', 'farmer', 'miner', 'hunter', 'chief', 'priest'];
//
//	job_list.forEach( (elem)
//	{
//		Job job = new Job(elem);
//		job.onLoad().then( (event)
//		{
//			Element droppiece = new Element.span();
//			droppiece.attributes['class'] = 'droppiece';
//
//			droppiece.appendText(job.data['name']);
//			dropdown.append(droppiece);
//        });
//	});
//
//	document.body.append(dropdown);

}
