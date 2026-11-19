const { readFileSync } = require('node:fs');
const { runInNewContext } = require('node:vm');
const assert = require('node:assert/strict');
const { test } = require('node:test');

const source = readFileSync(`${__dirname}/../files/directory-index.js`, 'utf8');
const handler = runInNewContext(`${source}\nhandler;`);

for (const [uri, expected] of [
    ['/', '/index.html'],
    ['/how-this-site-works/', '/how-this-site-works/index.html'],
    ['/how-this-site-works', '/how-this-site-works/index.html'],
    ['/case-studies/homelab-ipam/', '/case-studies/homelab-ipam/index.html'],
    ['/case-studies/homelab-ipam', '/case-studies/homelab-ipam/index.html'],
    ['/v1.0/about', '/v1.0/about/index.html'],
    ['/how-this-site-works/index.html', '/how-this-site-works/index.html'],
    ['/css/site.123.css', '/css/site.123.css'],
    ['/images/case-studies/ipam-dashboard.png', '/images/case-studies/ipam-dashboard.png'],
    ['/images/architecture/site-hosting.svg', '/images/architecture/site-hosting.svg'],
]) {
    test(`${uri} resolves to ${expected}`, () => {
        const request = { uri, method: 'GET', headers: {}, querystring: { ref: { value: 'test' } } };
        const result = handler({ request });
        assert.equal(result, request);
        assert.equal(result.uri, expected);
        assert.equal(result.querystring.ref.value, 'test');
        assert.equal(result.method, 'GET');
    });
}
