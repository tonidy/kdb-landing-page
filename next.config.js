/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'export',
  // Disable image optimization since it requires a server
  images: {
    unoptimized: true,
  },
  // Disable server components for static export
  experimental: {
    appDir: true,
  }
}

module.exports = nextConfig