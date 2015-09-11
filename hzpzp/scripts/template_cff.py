import FWCore.ParameterSet.Config as cms

# link to cards:
# https://github.com/cms-sw/genproductions/tree/31b6e7510443b74e0f9aac870e4eb9ae30c19d65/bin/MadGraph5_aMCatNLO/cards/production/13TeV/monoHiggs/PROCESS/TYPE


externalLHEProducer = cms.EDProducer("ExternalLHEProducer",
    args = cms.vstring('LOCATION'),
    nEvents = cms.untracked.uint32(5000),
    numberOfParameters = cms.uint32(1),
    outputFile = cms.string('cmsgrid_final.lhe'),
    scriptName = cms.FileInPath('GeneratorInterface/LHEInterface/data/run_generic_tarball_cvmfs.sh')
)
