// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin")
const fs = require("fs")
const path = require("path")
import colors from 'tailwindcss/colors'

module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/xfood_web.ex",
    "../lib/xfood_web/**/*.*ex"
  ],
  theme: {
    extend: {
      colors: {
        transparent: colors.transparent,
        brand: {
        '50': '#fff6ec',
        '100': '#ffecd3',
        '200': '#ffd4a5',
        '300': '#ffb66d',
        '400': '#ff8b32',
        '500': '#ff6a0a',
        '600': '#fd4f00',
        '700': '#cc3702',
        '800': '#a12b0b',
        '900': '#82260c',
        '950': '#461004',
        },
        primary: {
          '50': '#ebffff',
          '100': '#cdfcff',
          '200': '#a1f6ff',
          '300': '#61edff',
          '400': '#19daf7',
          '500': '#00bcdd',
          '600': '#0196b9',
          '700': '#0980a1',
          '800': '#116079',
          '900': '#135066',
          '950': '#053447',
        },
        neutral: colors.gray,
        secondary: {
          '50': '#fdf2f8',
          '100': '#fde6f3',
          '200': '#fccee8',
          '300': '#fba6d4',
          '400': '#f879bb',
          '500': '#f04498',
          '600': '#e02275',
          '700': '#c2145b',
          '800': '#a1134c',
          '900': '#861542',
          '950': '#520524',
        },
      }
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    // Allows prefixing tailwind classes with LiveView classes to add rules
    // only when LiveView classes are applied, for example:
    //
    //     <div class="phx-click-loading:animate-ping">
    //
    plugin(({addVariant}) => addVariant("phx-no-feedback", [".phx-no-feedback&", ".phx-no-feedback &"])),
    plugin(({addVariant}) => addVariant("phx-click-loading", [".phx-click-loading&", ".phx-click-loading &"])),
    plugin(({addVariant}) => addVariant("phx-submit-loading", [".phx-submit-loading&", ".phx-submit-loading &"])),
    plugin(({addVariant}) => addVariant("phx-change-loading", [".phx-change-loading&", ".phx-change-loading &"])),

    // Embeds Heroicons (https://heroicons.com) into your app.css bundle
    // See your `CoreComponents.icon/1` for more information.
    //
    plugin(function({matchComponents, theme}) {
      let iconsDir = path.join(__dirname, "../deps/heroicons/optimized")
      let values = {}
      let icons = [
        ["", "/24/outline"],
        ["-solid", "/24/solid"],
        ["-mini", "/20/solid"],
        ["-micro", "/16/solid"]
      ]
      icons.forEach(([suffix, dir]) => {
        fs.readdirSync(path.join(iconsDir, dir)).forEach(file => {
          let name = path.basename(file, ".svg") + suffix
          values[name] = {name, fullPath: path.join(iconsDir, dir, file)}
        })
      })
      matchComponents({
        "hero": ({name, fullPath}) => {
          let content = fs.readFileSync(fullPath).toString().replace(/\r?\n|\r/g, "")
          let size = theme("spacing.6")
          if (name.endsWith("-mini")) {
            size = theme("spacing.5")
          } else if (name.endsWith("-micro")) {
            size = theme("spacing.4")
          }
          return {
            [`--hero-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
            "-webkit-mask": `var(--hero-${name})`,
            "mask": `var(--hero-${name})`,
            "mask-repeat": "no-repeat",
            "background-color": "currentColor",
            "vertical-align": "middle",
            "display": "inline-block",
            "width": size,
            "height": size
          }
        }
      }, {values})
    })
  ]
}
