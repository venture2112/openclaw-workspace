import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        'brz-1': 'rgb(21, 21, 21)',
        'brz-2': 'rgb(34, 34, 50)',
        'brz-3': 'rgb(77, 99, 232)',
        'brz-4': 'rgb(188, 196, 246)',
        'brz-5': 'rgb(245, 212, 209)',
        'brz-6': 'rgb(239, 241, 249)',
        'brz-7': 'rgb(126, 126, 141)',
        'brz-8': 'rgb(255, 255, 255)',
      },
      fontFamily: {
        lato: ['Lato', 'sans-serif'],
      },
    },
  },
  plugins: [],
};

export default config;
