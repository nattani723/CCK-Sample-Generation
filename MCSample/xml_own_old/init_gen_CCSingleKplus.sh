#!/bin/sh

MY_N_EVENTS=200
MY_OUTPUT_FILE=genfile.root.local
MY_OUT_LOG=larInitGen.out
MY_ERR_LOG=larInitGen.err

echo "#include \"prodgenie_common_uboone_Filtered.fcl\"" > local_gen.fcl
echo "process_name: GenieGenFiltered" >> local_gen.fcl
echo "outputs.out1.fileName: \"prodgenie_numi_nu_filtered_CCSingleKplus_uboone_%tc_gen.root\"" >> local_gen.fcl
echo "source.maxEvents: 41000" >> local_gen.fcl
echo "physics.producers.generator: @local::standard_genie" >> local_gen.fcl
echo "physics.producers.generator.POTPerSpill: 5e13" >> local_gen.fcl
echo "physics.producers.generator.EventsPerSpill: 0" >> local_gen.fcl
echo "physics.producers.generator.GlobalTimeOffset: 5627.5" >> local_gen.fcl
echo "physics.producers.generator.RandomTimeOffset: 9600." >> local_gen.fcl
echo "physics.producers.generator.TopVolume: \"volCryostat\"" >> local_gen.fcl
echo "physics.producers.generator.BeamName: \"numi\"" >> local_gen.fcl
echo "physics.producers.generator.FluxType: \"dk2nu\"" >> local_gen.fcl
echo "physics.producers.generator.FluxSearchPaths: \"/pnfs/uboone/persistent/uboonebeam/numi_dk2nu_zero_threshold/FHC/\"" >> local_gen.fcl
echo "physics.producers.generator.FluxFiles: [\"g4numiv6_*.root\"]" >> local_gen.fcl
echo "physics.producers.generator.DetectorLocation: \"microboone-numi-v2\"" >> local_gen.fcl
echo "physics.producers.generator.GHepPrintLevel: 10" >> local_gen.fcl
echo "physics.producers.generator.EventGeneratorList: \"SingleKaon\"" >> local_gen.fcl
echo "physics.producers.generator.GXMLPATH: \"/uboone/app/users/taniuchi/KaonAna/singlekaongenie\"" >> local_gen.fcl
echo "physics.producers.generator.XSecTable: \"single_kaon_uboone_splines.xml\"" >> local_gen.fcl
echo "physics.filters.finalstatefilter.IsVerbose: false" >> local_gen.fcl
echo "physics.filters.finalstatefilter.isInclusive: true" >> local_gen.fcl
echo "physics.filters.finalstatefilter.PDG: [13, 321]" >> local_gen.fcl
echo "physics.filters.finalstatefilter.PDGCount: [1,1]" >> local_gen.fcl
echo "physics.filters.finalstatefilter.PDGCountExclusivity: [true, true]" >> local_gen.fcl
#echo "#include \"$MY_FCL_FILE\"" > local_gen.fcl
echo "physics.producers.generator.FluxCopyMethod: \"IFDH\"" >> local_gen.fcl
echo "physics.producers.generator.MaxFluxFileMB: 500" >> local_gen.fcl
echo "services.IFDH: {}" >> local_gen.fcl

if [ -f $MY_OUTPUT_FILE ]; then
        echo "File $MY_OUTPUT_FILE exists, so not generating again."
else
        echo "File $MY_OUTOUT_FILE does not exist, so running generation of it..."
        echo "Running command 'lar -c local_gen.fcl -T ./genfile_hist.root -o $MY_OUTPUT_FILE -n $MY_N_EVENTS > $MY_OUT_LOG 2> $MY_ERR_LOG' "
        lar -c local_gen.fcl -T ./genfile_hist.root -o genfile.root.temp -n $MY_N_EVENTS > $MY_OUT_LOG 2> $MY_ERR_LOG 
        lar -c standard_overlay_gen_SubRunPOTInEvent.fcl -s genfile.root.temp -T ./genfile_pot_hist.root -o $MY_OUTPUT_FILE -n -1 >> $MY_OUT_LOG 2>> $MY_ERR_LOG
        rm genfile.root.temp
fi

