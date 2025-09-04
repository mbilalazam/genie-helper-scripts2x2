void plot_true_energy() {
    // Open file and get tree
    TFile *f = TFile::Open("/global/homes/m/mazam/2x2_sim/run-genie/BilalTest.genie.nu/GST/0000000/BilalTest.genie.nu.0000000.gst.root");
    if (!f || f->IsZombie()) {
        printf("Error: cannot open file\n");
        return;
    }
    TTree *gst = (TTree*)f->Get("gst");
    if (!gst) {
        printf("Error: tree 'gst' not found\n");
        return;
    }

    // Create canvas
    TCanvas *c1 = new TCanvas("c1","CC antinu_mu on Ar",800,600);

    // Define histogram
    TH1D *hEv = new TH1D("hEv", "CC #bar{#nu}_{#mu} on Ar;True E_{#nu} (GeV);Events", 100, 0, 20);

    // Fill histogram with cuts: CC, muon antinu, Ar-40
    //gst->Draw("Ev >> hEv", "cc==1 && neu==-14 && tgt==1000180400");
    gst->Draw("Ev >> hEv");

    // Style
    gStyle->SetOptStat(1110);
    hEv->SetLineColor(kBlue);
    hEv->SetLineWidth(2);

    // Draw
    hEv->Draw();

    // Save image
    c1->SaveAs("true_energy_antinu_Ar.png");
    //c1->SaveAs("true_energy_antinu_Ar.pdf");
}
