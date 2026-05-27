import Link from "next/link";

export default function Footer() {
  const footerLinks = [
    { href: "/", label: "Home" },
    { href: "/quantum-bed-info/", label: "Bed Info" },
    { href: "/wellness-pod-recliner/", label: "Wellness Pod Recliner" },
    { href: "/quantum-health/", label: "Quantum Info" },
    { href: "/faq/", label: "FAQ" },
    { href: "/retail/", label: "Business" },
    { href: "/contact/", label: "Contact" },
    { href: "/privacy-policy/", label: "Privacy Policy" },
    { href: "/dmca/", label: "DMCA" },
    { href: "/ccpa/", label: "California Consumer Privacy Act (CCPA)" },
    { href: "/cookie-privacy-policy/", label: "Cookie Privacy Policy" },
    { href: "/financing/", label: "Financing" },
  ];

  return (
    <>
      {/* Footer Menu Section */}
      <footer className="bg-[rgb(239,241,249)] py-6">
        <div className="max-w-[1170px] mx-auto px-4 sm:px-6 lg:px-8">
          <nav className="flex flex-wrap justify-center gap-x-6 gap-y-2">
            {footerLinks.map((link) => (
              <Link
                key={link.href}
                href={link.href}
                className="text-black text-sm hover:opacity-70 transition-opacity"
              >
                {link.label}
              </Link>
            ))}
          </nav>
        </div>
      </footer>

      {/* Copyright Section */}
      <section className="bg-white py-5">
        <div className="max-w-[1170px] mx-auto px-4 sm:px-6 lg:px-8">
          <p className="text-[rgb(126,126,141)] text-base font-semibold tracking-wider text-center">
            © copyright 2024-2025 Quantum Wellness Bed. All Rights Reserved
          </p>
        </div>
      </section>
    </>
  );
}
