// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import AudioKit

class AKDryWetMixerTests: AKTestCase2 {
    let input1 = AKOscillator2()
    let input2 = AKOscillator2(frequency: 1280)

    func testDefault() {

        let mixer = AKDryWetMixer(dry: input1, wet: input2)
        output = mixer

        input1.start()
        input2.start()
        AKTest()
    }

    func testBalance0() {

        let mixer = AKDryWetMixer(dry: input1, wet: input2, balance: 0)
        output = mixer

        input1.start()
        input2.start()
        AKTest()
    }

    func testBalance1() {

        let mixer = AKDryWetMixer(dry: input1, wet: input2, balance: 1)
        output = mixer

        input1.start()
        input2.start()
        AKTest()
    }

}
