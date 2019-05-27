// DO NOT EDIT. This is code generated via package:gen_lang/generate.dart

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
// ignore: implementation_imports
import 'package:intl/src/intl_helpers.dart';

final _$ja = $ja();

class $ja extends MessageLookupByLibrary {
  get localeName => 'ja';
  
  final messages = {
		"hello" : MessageLookupByLibrary.simpleMessage("Hello"),
		"title" : MessageLookupByLibrary.simpleMessage("Hello world App"),
		"dialogLoading" : MessageLookupByLibrary.simpleMessage("読み込み中 ..."),
		"homeEmptyList" : MessageLookupByLibrary.simpleMessage("結果なし"),
		"homeSearchHint" : MessageLookupByLibrary.simpleMessage("検索 ..."),
		"homeRecommend" : MessageLookupByLibrary.simpleMessage("おすすめ"),
		"detailRate" : MessageLookupByLibrary.simpleMessage("コメント"),

  };
}

final _$zh_TW = $zh_TW();

class $zh_TW extends MessageLookupByLibrary {
  get localeName => 'zh_TW';
  
  final messages = {
		"hello" : MessageLookupByLibrary.simpleMessage("Hello"),
		"title" : MessageLookupByLibrary.simpleMessage("Hello world App"),
		"dialogLoading" : MessageLookupByLibrary.simpleMessage("載入中 ..."),
		"homeEmptyList" : MessageLookupByLibrary.simpleMessage("沒有結果"),
		"homeSearchHint" : MessageLookupByLibrary.simpleMessage("搜索 ..."),
		"homeRecommend" : MessageLookupByLibrary.simpleMessage("推介"),
		"detailRate" : MessageLookupByLibrary.simpleMessage("評論"),

  };
}

final _$en = $en();

class $en extends MessageLookupByLibrary {
  get localeName => 'en';
  
  final messages = {
		"hello" : MessageLookupByLibrary.simpleMessage("Hello"),
		"title" : MessageLookupByLibrary.simpleMessage("Hello world App"),
		"dialogLoading" : MessageLookupByLibrary.simpleMessage("Loading ..."),
		"homeEmptyList" : MessageLookupByLibrary.simpleMessage("No results"),
		"homeSearchHint" : MessageLookupByLibrary.simpleMessage("Search ..."),
		"homeRecommend" : MessageLookupByLibrary.simpleMessage("Recommend"),
		"detailRate" : MessageLookupByLibrary.simpleMessage("Comments"),

  };
}

final _$de = $de();

class $de extends MessageLookupByLibrary {
  get localeName => 'de';
  
  final messages = {
		"hello" : MessageLookupByLibrary.simpleMessage("Hello"),
		"title" : MessageLookupByLibrary.simpleMessage("Hello world App"),
		"dialogLoading" : MessageLookupByLibrary.simpleMessage("Wird geladen ..."),
		"homeEmptyList" : MessageLookupByLibrary.simpleMessage("Keine Ergebnisse"),
		"homeSearchHint" : MessageLookupByLibrary.simpleMessage("Suche ..."),
		"homeRecommend" : MessageLookupByLibrary.simpleMessage("Empfehlen"),
		"detailRate" : MessageLookupByLibrary.simpleMessage("Bemerkungen"),

  };
}



typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> _deferredLibraries = {
	"ja": () => Future.value(null),
	"zh_TW": () => Future.value(null),
	"en": () => Future.value(null),
	"de": () => Future.value(null),

};

MessageLookupByLibrary _findExact(localeName) {
  switch (localeName) {
    case "ja":
        return _$ja;
    case "zh_TW":
        return _$zh_TW;
    case "en":
        return _$en;
    case "de":
        return _$de;

    default:
      return null;
  }
}

/// User programs should call this before using [localeName] for messages.
Future<bool> initializeMessages(String localeName) async {
  var availableLocale = Intl.verifiedLocale(
      localeName,
          (locale) => _deferredLibraries[locale] != null,
      onFailure: (_) => null);
  if (availableLocale == null) {
    return Future.value(false);
  }
  var lib = _deferredLibraries[availableLocale];
  await (lib == null ? Future.value(false) : lib());

  initializeInternalMessageLookup(() => CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);

  return Future.value(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary _findGeneratedMessagesFor(locale) {
  var actualLocale = Intl.verifiedLocale(locale, _messagesExistFor,
      onFailure: (_) => null);
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}
