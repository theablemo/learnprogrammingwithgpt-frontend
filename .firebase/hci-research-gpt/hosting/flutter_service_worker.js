'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "3d940c2252caee9fdb0471828e868675",
"favicon.ico": "869c332945d8c23c9214ae140f456943",
"index.html": "021a231a0816d0c0c9d20b2267d30180",
"/": "021a231a0816d0c0c9d20b2267d30180",
"main.dart.js": "10dd8d82498859e00bd3cc30fcc5441e",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"icons/favicon-16x16.png": "14ef3d4a54527e06c79a046c5d691cd2",
"icons/favicon.ico": "869c332945d8c23c9214ae140f456943",
"icons/apple-icon.png": "cd4dc19992090c148186dd5fa95ac9c9",
"icons/apple-icon-144x144.png": "acd6784a7eb5223a0878171011d957e5",
"icons/android-icon-192x192.png": "b6ee21d0402f140393efcfeab272c566",
"icons/apple-icon-precomposed.png": "cd4dc19992090c148186dd5fa95ac9c9",
"icons/apple-icon-114x114.png": "546e3a4af887a85868c758e83b1a6f94",
"icons/ms-icon-310x310.png": "99066be21f0945fe82657fbfd11a9afb",
"icons/ms-icon-144x144.png": "acd6784a7eb5223a0878171011d957e5",
"icons/apple-icon-57x57.png": "442c06308e56ce19f4c4bcc7eab6cc97",
"icons/apple-icon-152x152.png": "872740da884c3e8aaf16c764cc0de2ac",
"icons/ms-icon-150x150.png": "6424c93bb7b1a0d42a15481a766e3f6b",
"icons/android-icon-72x72.png": "0651c19babe7b0fe0a47e588d7768b85",
"icons/android-icon-96x96.png": "c36d0508ea6ac669084f1d948b9dac83",
"icons/android-icon-36x36.png": "9bb2a1b3694fd366a7ee279f580937e3",
"icons/apple-icon-180x180.png": "efcff977e8ab857bca2c35517e8c2fd4",
"icons/favicon-96x96.png": "c36d0508ea6ac669084f1d948b9dac83",
"icons/android-icon-48x48.png": "7c71d82055edcb6d43bf442f75d489f5",
"icons/apple-icon-76x76.png": "6c47ca7ce399152d3eb8f672b4ee2fa5",
"icons/apple-icon-60x60.png": "c7e476d4a269145d78a5659fbc0aafb4",
"icons/android-icon-144x144.png": "acd6784a7eb5223a0878171011d957e5",
"icons/apple-icon-72x72.png": "0651c19babe7b0fe0a47e588d7768b85",
"icons/apple-icon-120x120.png": "fc3b99c7637d5fcc49a8b393a2ac186d",
"icons/favicon-32x32.png": "9bb0fba0d111a013c627d548c21b3dc4",
"icons/ms-icon-70x70.png": "99ea1bd7521ef3124771d338d4b502b0",
"manifest.json": "2deb51b846d8644e173373821198f83b",
"assets/AssetManifest.json": "3d25a5d10dfb9f19c40d59796bf6f919",
"assets/NOTICES": "6ff44833d2057b8dbffc9357b9a9a75c",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/packages/localization/test/assets/lang2/en_US.json": "b389499c34b7ee2ec98c62fe49e08fa0",
"assets/packages/localization/test/assets/lang2/pt_BR.json": "08e9b784a138126822761beec7614524",
"assets/packages/localization/test/assets/lang/en_US.json": "18804652fbce3b62aacb6cce6f572f3c",
"assets/packages/localization/test/assets/lang/pt_BR.json": "f999b93065fe17d355d1ac5dcc1ff830",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.bin": "076e1a94ac28143e58bcd2fb38f9fd6f",
"assets/fonts/MaterialIcons-Regular.otf": "78d41f8b9465069e7a2d2207e6cfdc40",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
