import Navigation from "../components/Navigation";
import Footer from "../components/Footer";

export default function CCPA() {
  return (
    <main className="min-h-screen">
      <Navigation />
      <section className="bg-white py-20">
        <div className="max-w-[1170px] mx-auto px-4 sm:px-6 lg:px-8">
          <h1 className="text-[49px] font-extrabold leading-[1.1] tracking-tight text-[rgb(34,34,50)] mb-8">
            California Consumer Privacy Act (CCPA)
          </h1>
          <p className="text-lg text-[rgb(126,126,141)]">
            Information about your rights under the California Consumer Privacy Act.
          </p>
        </div>
      </section>
      <Footer />
    </main>
  );
}
