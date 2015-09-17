import FWCore.ParameterSet.Config as cms

# link to cards:
# https://github.com/cms-sw/genproductions/tree/4e6dda7ecc882f106135d5a33c602f53bc4843a9/bin/MadGraph5_aMCatNLO/cards/production/13TeV/monoHiggs/Zp2HDM/Zprime_A0h_A0chichi/Zprime_A0h_A0chichi_MZp2500_MA0300


externalLHEProducer = cms.EDProducer("ExternalLHEProducer",
    args = cms.vstring('/cvmfs/cms.cern.ch/phys_generator/gridpacks/slc6_amd64_gcc481/13TeV/madgraph/V5_2.2.2/monoHiggs/Zp2HDM/Zprime_A0h_A0chichi/v1/Zprime_A0h_A0chichi_MZp2500_MA0300_tarball.tar.xz'),
    nEvents = cms.untracked.uint32(5000),
    numberOfParameters = cms.uint32(1),
    outputFile = cms.string('cmsgrid_final.lhe'),
    scriptName = cms.FileInPath('GeneratorInterface/LHEInterface/data/run_generic_tarball_cvmfs.sh')
)
