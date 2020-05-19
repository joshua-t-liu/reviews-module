// babel.config.js
module.exports = {
  presets: [
    [
      '@babel/preset-env',
      {
        targets: {
          node: 'current',
        },
      },
    ],
    '@babel/react',
  ],
  // "plugins": [
//   ["babel-plugin-styled-components", {
//     "ssr": false,
//     "fileName": false
//   }]
// ]
};