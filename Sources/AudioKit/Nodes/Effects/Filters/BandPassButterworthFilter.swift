// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation
import CAudioKit

/// These filters are Butterworth second-order IIR filters. They offer an almost flat
/// passband and very good precision and stopband attenuation.
/// 
public class BandPassButterworthFilter: AKNode, AKComponent, AKToggleable {

    public static let ComponentDescription = AudioComponentDescription(effect: "btbp")

    public typealias AKAudioUnitType = InternalAU

    public private(set) var internalAU: AKAudioUnitType?

    // MARK: - Parameters

    public static let centerFrequencyDef = AKNodeParameterDef(
        identifier: "centerFrequency",
        name: "Center Frequency (Hz)",
        address: akGetParameterAddress("BandPassButterworthFilterParameterCenterFrequency"),
        range: 12.0 ... 20_000.0,
        unit: .hertz,
        flags: .default)

    /// Center frequency. (in Hertz)
    @Parameter public var centerFrequency: AUValue

    public static let bandwidthDef = AKNodeParameterDef(
        identifier: "bandwidth",
        name: "Bandwidth (Hz)",
        address: akGetParameterAddress("BandPassButterworthFilterParameterBandwidth"),
        range: 0.0 ... 20_000.0,
        unit: .hertz,
        flags: .default)

    /// Bandwidth. (in Hertz)
    @Parameter public var bandwidth: AUValue

    // MARK: - Audio Unit

    public class InternalAU: AudioUnitBase {

        public override func getParameterDefs() -> [AKNodeParameterDef] {
            [BandPassButterworthFilter.centerFrequencyDef,
             BandPassButterworthFilter.bandwidthDef]
        }

        public override func createDSP() -> AKDSPRef {
            akCreateDSP("BandPassButterworthFilterDSP")
        }
    }

    // MARK: - Initialization

    /// Initialize this filter node
    ///
    /// - Parameters:
    ///   - input: Input node to process
    ///   - centerFrequency: Center frequency. (in Hertz)
    ///   - bandwidth: Bandwidth. (in Hertz)
    ///
    public init(
        _ input: AKNode,
        centerFrequency: AUValue = 2_000.0,
        bandwidth: AUValue = 100.0
        ) {
        super.init(avAudioNode: AVAudioNode())

        instantiateAudioUnit { avAudioUnit in
            self.avAudioUnit = avAudioUnit
            self.avAudioNode = avAudioUnit

            guard let audioUnit = avAudioUnit.auAudioUnit as? AKAudioUnitType else {
                fatalError("Couldn't create audio unit")
            }
            self.internalAU = audioUnit

            self.centerFrequency = centerFrequency
            self.bandwidth = bandwidth
        }
        connections.append(input)
    }
}
