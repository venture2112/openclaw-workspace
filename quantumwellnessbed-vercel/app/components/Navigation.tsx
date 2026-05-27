"use client";

import Link from "next/link";
import Image from "next/image";
import { useState } from "react";

export default function Navigation() {
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);

  const navLinks = [
    { href: "/quantum-health/", label: "Quantum Info" },
    { href: "/quantum-bed-info/", label: "Bed Info" },
    { href: "/wellness-pod-recliner/", label: "Wellness Pod Recliner" },
    { href: "/retail/", label: "Business" },
    { href: "/financing/", label: "Financing" },
    { href: "/faq/", label: "FAQ" },
    { href: "/contact/", label: "Contact" },
  ];

  return (
    <nav className="bg-[#1e293b]">
      <div className="max-w-[1170px] mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center py-2.5">
          {/* Logo */}
          <Link href="/" className="flex-shrink-0">
            <Image 
              src="https://quantumwellnessbed.com/wp-content/uploads/brizy/imgs/Quantum_Wellness_Bed_Logo_Transparent-115x115x0x17x115x81x1751939395.png"
              alt="Quantum Wellness Bed"
              width={115}
              height={81}
              className="h-[81px] w-auto"
              priority
            />
          </Link>

          {/* Desktop Navigation */}
          <div className="hidden lg:flex items-center space-x-0">
            {navLinks.map((link) => (
              <Link
                key={link.href}
                href={link.href}
                className="text-white hover:opacity-80 transition-opacity px-2.5 py-2 text-base font-medium"
              >
                {link.label}
              </Link>
            ))}
          </div>

          {/* Phone Button */}
          <a 
            href="tel:888-372-8632" 
            className="hidden lg:inline-flex items-center gap-2.5 px-[30px] py-3.5 bg-[#046bd2] text-white font-semibold text-base border-2 border-[#046bd2] transition-all duration-500 hover:bg-[#045cb4]"
          >
            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1} d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
            </svg>
            888-372-8632
          </a>

          {/* Mobile menu button */}
          <button
            onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
            className="lg:hidden p-2 text-white"
            aria-label="Toggle menu"
          >
            <svg className="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              {mobileMenuOpen ? (
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
              ) : (
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
              )}
            </svg>
          </button>
        </div>

        {/* Mobile Navigation */}
        {mobileMenuOpen && (
          <div className="lg:hidden py-4 border-t border-gray-700">
            <div className="flex flex-col space-y-2">
              {navLinks.map((link) => (
                <Link
                  key={link.href}
                  href={link.href}
                  className="text-white py-2 text-base"
                  onClick={() => setMobileMenuOpen(false)}
                >
                  {link.label}
                </Link>
              ))}
              <a 
                href="tel:888-372-8632" 
                className="inline-flex items-center justify-center gap-2.5 px-[30px] py-3.5 bg-[#046bd2] text-white font-semibold text-base border-2 border-[#046bd2] mt-2"
              >
                888-372-8632
              </a>
            </div>
          </div>
        )}
      </div>
    </nav>
  );
}
