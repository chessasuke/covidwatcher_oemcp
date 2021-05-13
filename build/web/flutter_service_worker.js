'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  ".git/COMMIT_EDITMSG": "3fbc68cdec0c296373bb2626ecf7c632",
".git/config": "5c57f9c7a345bdff301839cfac4de792",
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
".git/index": "5169a4bb6c21bbf426029a22587a8fdf",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "66af2f5f06dfff154c0be1834263a03a",
".git/logs/refs/heads/master": "66af2f5f06dfff154c0be1834263a03a",
".git/logs/refs/remotes/origin/master": "ec2ce6a3beb6fca4cd4ec42297d8a6ef",
".git/objects/01/eb318a4a31d6f639d563e9f0a754efc8a3c2fd": "634f21e5c9ea5be2d4888c407aae91b2",
".git/objects/08/f2a3f4b72992860bdc7803fe8013d23dd4bb15": "98623008fa323174b5a65b43aa2875cd",
".git/objects/09/10d44959370fad8d1505fa1e70570167a86c94": "55f27a84f34d077686847de60a2dc5fc",
".git/objects/0a/9327e45c498ad45428f80c20de72ed9e89b7e6": "978c0692c49a6b8dd64178c55b3fb22e",
".git/objects/16/da4f9b3dfdf4e94f843da4c100bcab9bf37d4b": "c2b75207ae28f1451bb102027c955650",
".git/objects/1b/2ae57b873615b55b81939fca712f28ffb50a77": "f1327ee54ec240513613c41a0686cdf2",
".git/objects/1c/4236dff616f1bcbdd0fdb5b0dab43cf29ce05b": "f8064696d2ca8a9db9c9040ce5276530",
".git/objects/1d/de83500d60421b37ba26320005554668fc206f": "a9a7145bda4f39687373c52a045aa7b8",
".git/objects/20/5bb5db271c6d8de8399864c7bb9b917f638893": "c993b22f115d7f3ae6d5b7b212806539",
".git/objects/20/87f8f560cd2ffc5510bfc96b6b878206fef544": "b6683df7b92e63d1d53b9aa9535e5d9b",
".git/objects/20/d9100de45b7c4d9209dd7d9d0455fe30e6a001": "b6d9ba86803660014244f6d025d7c2b4",
".git/objects/21/c79af49bb905679e5292b2a23b22573e20eaa5": "3b32d97f1654516a3fa759bf4b02d87c",
".git/objects/23/637bc3573701e2ad80a6f8be31b82926b4715f": "5f84f5c437bb2791fdc8411523eae8ff",
".git/objects/28/5e1d1c2b57fa127cc9bec6499658369685e4b2": "ec7e18e8b0bfb8372114e120d183d4b3",
".git/objects/33/9207fe342ebe36cad6699afaae53f964accc0a": "ec0b6b08932f4186d13b0f3e0438e47d",
".git/objects/35/e106a586f4b768420d62382fb76dab10a9ced2": "bcb941278b333b49786839eb0c9dc136",
".git/objects/35/f7025081b9badbee8180a267d87a5394067263": "5976b8982c8c5ecbfb792b4bd6cf708e",
".git/objects/38/1e66deb6b705334bb74da28c7c371c369e4d9c": "3379c1fee65a697aea25080e47143bc2",
".git/objects/3a/249cdf7ee82f21d0cf1c27ccd289295eff860e": "21be83086ac3169aafad9288f1ea8429",
".git/objects/3b/3ba8c730a9192ac15222cae1f85ed185760306": "158203b3b2ac0f33636c10c054de9a0d",
".git/objects/42/7dd5f1106d125f74c04233d6e64c66f2de00f7": "8a18f3e46c26ae3c4f0d117fb1ce5de9",
".git/objects/54/0eada29112719a0269fdf81db18739972d22bf": "08322868585b95cb82ad35a1eccee38d",
".git/objects/58/3c29811a2e1ccb8fcafa1894e4ec5943fd6e63": "c3d0f00ff7f987156bca2180ef34184b",
".git/objects/65/cc402d58b8759e1021663ac749a0455de1047f": "186bc655efd14d48021f7fa741b17e22",
".git/objects/66/1d2cb4339e52a892e0df6c13bdc941e4a2778c": "358193d1c0668e33a583c7fd464a9513",
".git/objects/66/a750661407900f99df7f1beabf6a374df7bcdd": "9b51cde7c781164d7b7cfa372b9c6893",
".git/objects/6c/7b3c69a7e402ae55f1816d7c11d3fe6d7d1bde": "3926bbafaabec0378b24e788b5c5ca97",
".git/objects/6f/c580a5bff635ac890a8630f6e3eb561b88457a": "2b79380d3d649ea5323af6782042c4fc",
".git/objects/77/85bbf06afcad15c690267714277f5e4e08775b": "fa5e0b0d29b3123d6f38d1cf879028fc",
".git/objects/78/d58d5359b600f0369b18cd09b89a9c53fcf41c": "567f887fc67466c5868f35876c6e05d6",
".git/objects/79/ba7ea0836b93b3f178067bcd0a0945dbc26b3f": "f3e31aec622d6cf63f619aa3a6023103",
".git/objects/7e/8cd33dc4a6521ab7d40c83c2350ffe2edebf63": "89b5b2c0d4fa8ba67d3a19fdb614f487",
".git/objects/7e/c7acfeb46472a8bacc61aae8f0434446384215": "9f325b4faf9dcf55b97f17e90ebe1d81",
".git/objects/83/396ff553245dd144e577d94aeedea93a3907d0": "ddfb20da7d08caa239e60a789beed97b",
".git/objects/84/c3114b0638b58ad398ff70189c2e38bbbf9dcd": "fc8c60447e1cbbb8cded6b56fbe01db0",
".git/objects/86/9055f9426721a078cc068aeadaad15150ba293": "5380e623d6c80e2a624c6d10cfaec413",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/89/fc9e292c05d19672cd09f452d75c5cfe9fdfbb": "be20ac74ccb8fbfa6ee47945d0ea89ca",
".git/objects/8a/0d58250f0c59fc198c53a3d88501236a8d39dd": "642570c0b6c0dca2a7d293266ac4964e",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8c/36e83942dfe842bce43446e3917da3d714db88": "790331b2911f164fbb44536a75694bc5",
".git/objects/8d/8d82f84d5bb79fea15c4b127e39b087dc406c9": "2b6c1994cfe1089a9ca1430f502ed482",
".git/objects/93/7b33bd85c3c4e7f92ff054110c82537b8ef9a2": "a72ad9ead703d9793f28b02c155d2f6a",
".git/objects/9f/cebeb7e59cb431f6a50bd3e54d764b661f79ae": "6c45b45c937c2f0b878743d6ec3be1a7",
".git/objects/a1/3837a12450aceaa5c8e807c32e781831d67a8f": "bfe4910ea01eb3d69e9520c3b42a0adf",
".git/objects/a3/97e6138294f78152cee53c079468cbe67953ad": "5dbf475b99f7c68a0aebaffe3cc072b3",
".git/objects/a5/79de504797fa4d8de84135944bcc7bcc3fbf9a": "97eed9f96d502d7b75d5629c6b57f2ae",
".git/objects/a6/4e3f57baa3219730c2ea6721f637429de6ff9a": "621e92dd8166a23e47a0da0d2d8297bb",
".git/objects/a8/3a17d54b6dc2156c855c6580301cefc9c8d017": "6525101be8d70b808a809af9c83fa4ad",
".git/objects/a8/548392e46ce10bd1627947201262231afa24c4": "8499ef6d2897025d4357819b2f1359e0",
".git/objects/a9/154f0fafadf8a25283f8f68a5c11347fb85160": "7563f71b3277de3a76b7172af455b9dd",
".git/objects/b0/17d8b3de6485e9d9387fd470e89b389fc87c30": "0ca052c572f93f6a2c5aab7f83c6ef13",
".git/objects/b6/41afa8cfe8ccbf8f911ee8fe3a78f6800b462d": "4b5e75e6d93decaf7dc39c8df0ce7082",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/bd/0cc0c47aec27f288010c536b4a2b3ccdf1a5fa": "0b398fb568efd06b5607faf01a83785c",
".git/objects/be/3b71d95ae7e09acc34e48a4d44315414718524": "131980569e30958b04fb2171abdcd208",
".git/objects/c5/127713fd2d0ecdce192e6f478c0f3052cacc28": "04831cc8432f81435d234a31038ea687",
".git/objects/ce/7bcdc14964c52f3f338d7f3b1e37893171e006": "7be38d350d9f11cbd44709c586cf5703",
".git/objects/cf/1c1abe04547ec9b556ed44a012b7f34c875215": "1065578c3e56d17c1ca55fef841bc49d",
".git/objects/d1/912cacf64a9b3e03efa014e7d853a69f4ff99c": "fbc71aa957627ef52cd6de98c645c7f9",
".git/objects/d3/83b5826df9f66a20eb9167a2ef9bf9ece3087c": "6c7dced8068dce73f964a1532ff9eab7",
".git/objects/d4/0189839ff302b56ef50ca57d0c04e51d6c3f6b": "21ca82209ada9b26ebda326864bf9240",
".git/objects/e3/3bc0aa77cf6fa1415b5abfa31cc44a006db02a": "bbc5579eff1d7fd1db484653795103db",
".git/objects/e5/8caa536785c955714d1ea132b31d3d421af165": "aaa33231f39113df86845249e435dd8e",
".git/objects/e5/951dfb943474a56e611d9923405cd06c2dd28d": "c6fa51103d8db5478e1a43a661f6c68d",
".git/objects/ec/bd02dfc3638e98a4828642cf5b7c03b03cd280": "c8cc069a4a20b2084cafd1e500e93c6b",
".git/objects/ef/8123433508d76273f0ba050d1d4da0d611e28c": "78ab447fb14850b751db2aaf194bed36",
".git/objects/f1/612c3cbba51bc1d54e8f1171fc629e0887dcca": "029cf1c86406b8f79029a42f132d5527",
".git/objects/f2/5787c93ad00665f0f797a43ab397f0628a273e": "59e425d1456034072d902c75d18ec75f",
".git/objects/fc/50966279de3bd224316658dd33b4fabce4ee68": "df2a0a650ae164dcd81913ef0a2a0ff1",
".git/objects/ff/03c88ff437ad151c7827da1d17d8fbaf1ee263": "95269ee77d58937db723fdcc7c9e0e98",
".git/refs/heads/master": "ed5941831b71bb596ffe3f1f6fefa5e0",
".git/refs/remotes/origin/master": "ed5941831b71bb596ffe3f1f6fefa5e0",
"assets/AssetManifest.json": "08273f7476ddd8bd98a80e70091c62bc",
"assets/assets/report.riv": "fc859a224ce95878db8b73b1c23fd8a7",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/images/campusmap.jpg": "3e46bf2e6da802032ac814a6fb788e60",
"assets/images/cdc1.png": "f4072e04d0c7ae146a2ce3b33f783f37",
"assets/images/logo.png": "f89f80379abe4422c71f6f7115b0bd94",
"assets/images/utd.png": "b449b79ee41949fcf66495723ea1bbd7",
"assets/images/who.png": "33736bb3086bb12b67f7f032fef817d2",
"assets/NOTICES": "26f682b989ead4a518adf85ce023ef00",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "831eb40a2d76095849ba4aecd4340f19",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "a126c025bab9a1b4d8ac5534af76a208",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "d80ca32233940ebadc5ae5372ccd67f9",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"firebase-messaging-sw.js": "f5dacf6ed374b5783e62e43d80c65629",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "bfb2d76b133f37567a823f321ebd2147",
"/": "bfb2d76b133f37567a823f321ebd2147",
"main.dart.js": "bc00cad603ae644a9cf2f74ee76c778e",
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
