import Navigation from "../components/Navigation";
import Footer from "../components/Footer";

export default function Contact() {
  return (
    <main className="min-h-screen">
      <Navigation />
      <section className="bg-[rgb(239,241,249)] py-20">
        <div className="max-w-[800px] mx-auto px-4 sm:px-6 lg:px-8">
          <h1 className="text-[49px] font-extrabold leading-[1.1] tracking-tight text-[rgb(34,34,50)] mb-8 text-center">
            Contact Us
          </h1>
          <form className="space-y-4">
            <input 
              type="text" 
              placeholder="Name" 
              required
              className="w-full px-5 py-4 border border-gray-200 text-base focus:outline-none focus:border-[rgb(77,99,232)]"
            />
            <input 
              type="email" 
              placeholder="Email Address" 
              required
              className="w-full px-5 py-4 border border-gray-200 text-base focus:outline-none focus:border-[rgb(77,99,232)]"
            />
            <input 
              type="tel" 
              placeholder="Phone" 
              required
              className="w-full px-5 py-4 border border-gray-200 text-base focus:outline-none focus:border-[rgb(77,99,232)]"
            />
            <textarea 
              placeholder="Your message" 
              rows={4}
              className="w-full px-5 py-4 border border-gray-200 text-base focus:outline-none focus:border-[rgb(77,99,232)] resize-y min-h-[120px]"
            ></textarea>
            <div className="text-center pt-4">
              <button 
                type="submit" 
                className="inline-flex items-center px-[42px] py-3.5 bg-[rgb(77,99,232)] text-white font-semibold text-base border-2 border-[rgb(77,99,232)] transition-all duration-500 hover:bg-[rgba(77,99,232,0.8)]"
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
