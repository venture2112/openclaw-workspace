import Link from "next/link";
import Image from "next/image";
import Navigation from "./components/Navigation";
import Footer from "./components/Footer";

export default function Home() {
  return (
    <main className="min-h-screen">
      <Navigation />

      {/* Hero Section */}
      <section className="bg-[#1e293b] pt-11 pb-16">
        <div className="max-w-[1170px] mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid lg:grid-cols-2 gap-8 items-center">
            <div>
              <h1 className="text-[56px] font-extrabold leading-[1.1] tracking-tight text-white mb-6 underline decoration-white">
                Relax & Recharge with the Quantum Wellness Bed
              </h1>
              <p className="text-lg font-extrabold leading-relaxed text-white mb-8">
                The Quantum Wellness Bed, is the latest state-of-the-art healing technology that harnesses the power of combining Cellular Resonance, Negative Ion, Vibrational, Far Infrared, Graphene Heating, as well as Chromotherapy and Gyromagnetic Therapy to help you relax, recharge, and realign with your highest wellness potential.
              </p>
              <Link 
                href="/quantum-bed-info/" 
                className="inline-flex items-center px-[42px] py-3.5 bg-[#046bd2] text-white font-semibold text-base border-2 border-[#046bd2] transition-all duration-500 hover:bg-[#045cb4]"
              >
                Learn More
              </Link>
            </div>
            <div className="flex justify-center">
              <Image 
                src="https://quantumwellnessbed.com/wp-content/uploads/2025/06/quantum-wellness-bed-with-model.png"
                alt="Quantum Wellness Bed"
                width={600}
                height={500}
                className="w-full max-w-[600px] h-auto"
                priority
              />
            </div>
          </div>
        </div>
      </section>

      {/* Spacer */}
      <div className="h-[60px] bg-[#1e293b]"></div>

      {/* Quantum Technology Section */}
      <section className="bg-white py-[75px]">
        <div className="max-w-[1170px] mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid lg:grid-cols-2 gap-12 items-center">
            <div>
              <Image 
                src="https://quantumwellnessbed.com/wp-content/uploads/brizy/imgs/quantum-healing-technology-scaled-865x457x86x0x555x457x1750549199.jpg"
                alt="Quantum Healing Technology"
                width={555}
                height={457}
                className="w-full h-auto"
              />
            </div>
            <div>
              <h2 className="text-[49px] font-extrabold leading-[1.1] tracking-tight text-[#1e293b] mb-6">
                Quantum Technology
              </h2>
              <h5 className="text-lg font-bold leading-relaxed text-[#334155] mb-4">
                <a href="https://en.wikipedia.org/wiki/Quantum_healing" target="_blank" rel="noopener noreferrer" className="text-[#334155] hover:text-[#1e293b]">
                  Quantum wellness
                </a>
                {' '}is a revolutionary approach to health and well-being. It takes a holistic view of the body, mind and spirit in order to create balance and harmony within each individual.
              </h5>
              <h5 className="text-lg font-bold leading-relaxed text-[#334155]">
                Quantum wellness focuses on creating a state of energetic resonance that allows for optimal physical, emotional and spiritual health. At its core,{' '}
                <a href="https://www.quantumenergybeds.com/quantum-health/" target="_blank" rel="noopener noreferrer" className="text-[#334155] hover:text-[#1e293b]">
                  quantum
                </a>
                {' '}wellness is based on the idea that all matter has an energy that can be manipulated through understanding how this energy works on a fundamental level.
              </h5>
              <div className="mt-8">
                <Link 
                  href="/quantum-health/" 
                  className="inline-flex items-center px-[42px] py-3.5 bg-[#046bd2] text-white font-semibold text-base border-2 border-[#046bd2] transition-all duration-500 hover:bg-[#045cb4]"
                >
                  Learn More
                </Link>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* How Does It Work Section */}
      <section className="bg-[#1e293b] py-[75px]">
        <div className="max-w-[1170px] mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid lg:grid-cols-2 gap-12 items-center">
            <div>
              <h2 className="text-[47px] font-extrabold leading-[1.1] tracking-tight text-white mb-6">
                How Does It Work
              </h2>
              <h5 className="text-lg font-bold leading-relaxed text-white mb-6">
                <a href="https://www.quantumenergybeds.com/quantum-bed-info/" target="_blank" rel="noopener noreferrer" className="text-white hover:opacity-80">
                  The Quantum Energy Wellness Bed Pod
                </a>
                {' '}unites multiple potent modalities, such as far infrared light and heat, vibration, negative ions, oxygen, and so much more. These harmonious modalities generate a perpetual quantum field and biophotons – which are light particles that the body can take in providing ultimate wellness.
              </h5>
              <Link 
                href="/quantum-bed-info/" 
                className="inline-flex items-center px-[42px] py-3.5 bg-[#046bd2] text-white font-semibold text-base border-2 border-[#046bd2] transition-all duration-500 hover:bg-[#045cb4]"
              >
                Learn More
              </Link>
            </div>
            <div className="flex justify-center">
              <Image 
                src="https://quantumwellnessbed.com/wp-content/uploads/2025/06/quantum-wellness-bed-modalities.jpeg"
                alt="Quantum Wellness Bed Modalities"
                width={600}
                height={400}
                className="w-full max-w-[600px] h-auto"
              />
            </div>
          </div>
        </div>
        <div className="h-10"></div>
      </section>

      {/* Why Everyone Needs It Section */}
      <section className="bg-white py-[75px]">
        <div className="max-w-[1170px] mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid lg:grid-cols-2 gap-12 items-center">
            <div>
              <Image 
                src="https://quantumwellnessbed.com/wp-content/uploads/brizy/imgs/woman-grounding-685x457x10x0x555x457x1750549199.jpg"
                alt="Woman Grounding"
                width={555}
                height={457}
                className="w-full h-auto"
              />
            </div>
            <div>
              <h2 className="text-[50px] font-extrabold leading-[1.1] tracking-tight text-[#1e293b] mb-6">
                Why Everyone Needs It
              </h2>
              <h5 className="text-lg font-bold leading-relaxed text-[#334155] mb-4">
                The Wellness Pod provides an innovative solution to the challenge of modern lifestyles which prevent people from accessing essential resources such as exercise, sunlight, fresh air and clean water for maintaining health.
              </h5>
              <h5 className="text-lg font-bold leading-relaxed text-[#334155]">
                It combines heat, infrared, oxygen, negative ion, specialized magnetic energy to recreate these natural resources in order to help the body reach total-body wellness and cellular repair.
              </h5>
              <div className="mt-8">
                <Link 
                  href="/quantum-bed-info/" 
                  className="inline-flex items-center px-[42px] py-3.5 bg-[#046bd2] text-white font-semibold text-base border-2 border-[#046bd2] transition-all duration-500 hover:bg-[#045cb4]"
                >
                  Learn More
                </Link>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Contact Form Section */}
      <section className="bg-[#f9fafb] py-[75px]">
        <div className="max-w-[800px] mx-auto px-4 sm:px-6 lg:px-8">
          <h2 className="text-[49px] font-extrabold leading-[1.1] tracking-tight text-[#1e293b] mb-8 text-center">
            Drop us a line
          </h2>
          <form className="space-y-4">
            <input 
              type="text" 
              placeholder="Name" 
              required
              className="w-full px-5 py-4 border border-gray-200 text-base focus:outline-none focus:border-[#046bd2]"
            />
            <input 
              type="email" 
              placeholder="Email Address" 
              required
              className="w-full px-5 py-4 border border-gray-200 text-base focus:outline-none focus:border-[#046bd2]"
            />
            <input 
              type="tel" 
              placeholder="Phone" 
              required
              className="w-full px-5 py-4 border border-gray-200 text-base focus:outline-none focus:border-[#046bd2]"
            />
            <textarea 
              placeholder="Your message" 
              rows={4}
              className="w-full px-5 py-4 border border-gray-200 text-base focus:outline-none focus:border-[#046bd2] resize-y min-h-[120px]"
            ></textarea>
            <div className="text-center pt-4">
              <button 
                type="submit" 
                className="inline-flex items-center px-[42px] py-3.5 bg-[#046bd2] text-white font-semibold text-base border-2 border-[#046bd2] transition-all duration-500 hover:bg-[#045cb4]"
              >
                Send Message
              </button>
            </div>
          </form>
        </div>
      </section>

      <Footer />
    </main>
  );
}
