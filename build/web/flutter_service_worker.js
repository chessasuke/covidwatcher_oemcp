'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  ".git/COMMIT_EDITMSG": "e4ff8a5d5dccfb429f4d4d39d27d410d",
".git/config": "8dd330db9890ba5ffeb914e1ecd690cb",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "4cf2d64e44205fe628ddd534e1151b58",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "ea587b0fae70333bce92257152996e70",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "3c5989301dd4b949dfa1f43738a22819",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/update.sample": "7bf1fcc5f411e5ad68c59b68661660ed",
".git/index": "6643cc5b92f6db711cb913728bd10e60",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "ed4f90b4140745119b45f88f3d2c0eb3",
".git/logs/refs/heads/master": "ed4f90b4140745119b45f88f3d2c0eb3",
".git/logs/refs/remotes/origin/master": "34164d330812fe9e636de25faf613966",
".git/objects/01/eb318a4a31d6f639d563e9f0a754efc8a3c2fd": "634f21e5c9ea5be2d4888c407aae91b2",
".git/objects/07/1d5442eb70f1b9079e7901ac562e4d7894db14": "d46e19594ae680059d22edb44f1f79dc",
".git/objects/09/11ddf573114e4aec1542b243eff3a05e7feb6c": "c03e39a9b8a8c4fad550a4ce0bf0050e",
".git/objects/0a/9327e45c498ad45428f80c20de72ed9e89b7e6": "978c0692c49a6b8dd64178c55b3fb22e",
".git/objects/0b/88a2a40d9660ccb6d3c336767f1bacdb9c0264": "ff400e967cb78d158e75408408f37035",
".git/objects/1c/4236dff616f1bcbdd0fdb5b0dab43cf29ce05b": "f8064696d2ca8a9db9c9040ce5276530",
".git/objects/1d/de83500d60421b37ba26320005554668fc206f": "a9a7145bda4f39687373c52a045aa7b8",
".git/objects/20/5bb5db271c6d8de8399864c7bb9b917f638893": "c993b22f115d7f3ae6d5b7b212806539",
".git/objects/20/87f8f560cd2ffc5510bfc96b6b878206fef544": "b6683df7b92e63d1d53b9aa9535e5d9b",
".git/objects/20/d9100de45b7c4d9209dd7d9d0455fe30e6a001": "b6d9ba86803660014244f6d025d7c2b4",
".git/objects/23/637bc3573701e2ad80a6f8be31b82926b4715f": "5f84f5c437bb2791fdc8411523eae8ff",
".git/objects/2f/3afdc548087346048f1495f308e8bb6d4b4643": "adb4c08e743784ee174609ad1ee4b9ac",
".git/objects/3a/249cdf7ee82f21d0cf1c27ccd289295eff860e": "21be83086ac3169aafad9288f1ea8429",
".git/objects/3e/b22acb95e503fd6aa6d5f17428a18c86ed5fbb": "7daaa869c7783e53056140f680b86cc3",
".git/objects/42/9378fb005a68af82f22cb9ad044c78a4b26e1a": "b12ed5e0682eec5708029a6e7cccdacd",
".git/objects/44/591bd591ab48e582d7686fb4c735d4d2e506b9": "2813cd3ee5b943bb5d07ceda58b2faf0",
".git/objects/4c/f4b6d5fa00bfe6a2fb0cd898363c9110af05f2": "8964b6f149655b9ba8e88743a7b6dba6",
".git/objects/50/a862967856baa39b38cb5e860ce2114d719bf6": "115e6362cce1310176207ccf44a54282",
".git/objects/55/8d8861d9724e158d8d66e095711771cefbf3a9": "c8debcb51e86568c80df284dc921c3cf",
".git/objects/57/42d1095fb48f3559ec111d8df491bf1bfe2f77": "1132d7a280849963f8dc5f406067fe90",
".git/objects/59/0d57366cd4f831d108defb79173cb614cdf805": "4205e37566a745741d9afed7d0c5bd9e",
".git/objects/66/1d2cb4339e52a892e0df6c13bdc941e4a2778c": "358193d1c0668e33a583c7fd464a9513",
".git/objects/73/17e1df469210f5816ccdf501b45bd890a0d66e": "efb7a2e73a4e4e47fdb49aa6ed0b7788",
".git/objects/79/ba7ea0836b93b3f178067bcd0a0945dbc26b3f": "f3e31aec622d6cf63f619aa3a6023103",
".git/objects/84/ab4573a1e58d3346db1032f9536fb48c8e581e": "b76cc6c52ca3220053a5c7f0508471d5",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/93/7b33bd85c3c4e7f92ff054110c82537b8ef9a2": "a72ad9ead703d9793f28b02c155d2f6a",
".git/objects/a1/3837a12450aceaa5c8e807c32e781831d67a8f": "bfe4910ea01eb3d69e9520c3b42a0adf",
".git/objects/a4/c63d5c24f4e19727b038866ca1fb30bd889954": "001647bea5281c46562a7399e00aa324",
".git/objects/a6/4e3f57baa3219730c2ea6721f637429de6ff9a": "621e92dd8166a23e47a0da0d2d8297bb",
".git/objects/a8/3a17d54b6dc2156c855c6580301cefc9c8d017": "6525101be8d70b808a809af9c83fa4ad",
".git/objects/a8/548392e46ce10bd1627947201262231afa24c4": "8499ef6d2897025d4357819b2f1359e0",
".git/objects/a9/154f0fafadf8a25283f8f68a5c11347fb85160": "7563f71b3277de3a76b7172af455b9dd",
".git/objects/af/e107dd37a916c8f2cb788d3b37a8fb3ac9592f": "c73b5d6d6be4230c44cb2716f9215997",
".git/objects/b0/d6b3ccbea8479ffc206a19207caffd53815186": "c509d35ba7b76e50d142a43697d36ee4",
".git/objects/b6/f7f216138cbd0bac97d4fd71a2047a3e60cc79": "17831a647997dff0ed14056e402380d9",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/bc/3372d58096adc7dca416854195e142d1247817": "08941359ee5e924126b4ee51f481d242",
".git/objects/bd/0cc0c47aec27f288010c536b4a2b3ccdf1a5fa": "0b398fb568efd06b5607faf01a83785c",
".git/objects/be/3b71d95ae7e09acc34e48a4d44315414718524": "131980569e30958b04fb2171abdcd208",
".git/objects/c5/142fb6c87940958ae39854b7eb29eb0c0b709a": "5d894d22e8292b3620508d48c8bcbadb",
".git/objects/cf/1c1abe04547ec9b556ed44a012b7f34c875215": "1065578c3e56d17c1ca55fef841bc49d",
".git/objects/d5/4a52bac529135a70a21dc148e076c2785ad0ed": "70ffa65e4b9cfcf958479e67b8fb82fc",
".git/objects/db/3d539012f9df2e1f0a788d2da38863950ccb7c": "052b5588796f7a7a0ac17caa6e5fcd87",
".git/objects/e5/951dfb943474a56e611d9923405cd06c2dd28d": "c6fa51103d8db5478e1a43a661f6c68d",
".git/objects/e7/3361435046773292b29e9721ec5488499c1cb7": "326118825e84fbb921d9d309ea9c4c16",
".git/objects/e7/61bc240773173736945765ad6d9124fff3aa3c": "f16735e85d6308b78fd086c534659965",
".git/objects/ec/bd02dfc3638e98a4828642cf5b7c03b03cd280": "c8cc069a4a20b2084cafd1e500e93c6b",
".git/objects/f2/5787c93ad00665f0f797a43ab397f0628a273e": "59e425d1456034072d902c75d18ec75f",
".git/refs/heads/master": "5a3b78ec5eb44c030544108c1b80201c",
".git/refs/remotes/origin/master": "5a3b78ec5eb44c030544108c1b80201c",
"assets/AssetManifest.json": "c36067ca588d47ffe036fd086f9431da",
"assets/assets/australia.json": "581d9a831f3376bcedbb019e5975f2fe",
"assets/assets/report.riv": "fc859a224ce95878db8b73b1c23fd8a7",
"assets/assets/utdMap.json": "8b7959fb0b226b5cb5e1354aea274216",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/images/campusmap.jpg": "3e46bf2e6da802032ac814a6fb788e60",
"assets/images/cdc1.png": "f4072e04d0c7ae146a2ce3b33f783f37",
"assets/images/logo.png": "f89f80379abe4422c71f6f7115b0bd94",
"assets/images/utd.png": "b449b79ee41949fcf66495723ea1bbd7",
"assets/images/who.png": "33736bb3086bb12b67f7f032fef817d2",
"assets/NOTICES": "ebe03ec43222ec41fc99397d0be73bd4",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "831eb40a2d76095849ba4aecd4340f19",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "a126c025bab9a1b4d8ac5534af76a208",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "d80ca32233940ebadc5ae5372ccd67f9",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"firebase-messaging-sw.js": "d4528fa0301aab73683ca0c22cc32faa",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "9358e4cfcc63a43e4c4cbef8c5975e74",
"/": "9358e4cfcc63a43e4c4cbef8c5975e74",
"main.dart.js": "309d50fac893bb2cfe4eb8e63550f2bb",
"manifest.json": "e36ef6b9ad431942acb532f597160258",
"version.json": "1d79307ea330238d672b8bb532f58ef1"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
