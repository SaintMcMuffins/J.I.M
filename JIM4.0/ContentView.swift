//
//  ContentView.swift
//  JIM4.0
//
//  Created by Brian Nguyen on 4/22/23.
//

import SwiftUI
import AudioToolbox
import CoreMotion
    //------------------------------------Colors--------------------------------------------------------
var purple = UIColor(rgb: 0x755B69)
var green = UIColor(rgb: 0x96C5B0)
var dark = UIColor(rgb: 0x2D2D2A)
var oppGreen = UIColor(rgb: 0x693a4f)

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}


//------------------------------------Quotes--------------------------------------------------------
var quote = ["The human body has 650 muscles.",
             "The only exercise you should hold your breath for is underwater swimming.",
             "The heart is the strongest muscle in the body.",
             "Nearly 50% of all young people ages 12-21 are not vigorously active on a daily basis.",
             "For every pound of muscle gained, the body burns 50 extra calories every day.",
             "Only 13% of men are physically fit.",
             "More than 30% of children ages 6 to 11 are overweight, and over 15% are obese.",
             "On average, a person walks 70,000 miles in their lifetime.",
             "Exercise makes you feel more energized because it releases endorphins into the blood.",
             "Movement in exercise helps relieve stress by producing a relaxation response which serves as a position distraction.",
             "Push yourself like you are constipated on the toilet",
             "Whatever you do, always give 100%. Unless you're donating blood",
             "Do things today that won’t make you regret tomorrow",
             "Change takes time and through consistency will you see the change you want. So keep going!",
             "Don’t take on more than you can handle. Conquer what you can and prepare for the battles ahead",
             "Hustle 4 dat muscle",
             "Do it so you can fit in those skinny jeans",
             "That one guy, said you can’t do it. Prove them wrong.",
             "Listening to music while exercising can improve work out performance by 15%.",
             "Cardiovascular exercise helps create new brain cells. This enhances brainpower and brain activity.",
             "If you exercise 3 times a week for 45 minutes, you can help prevent signs of ageing.",
             "Exercising regularly helps boost your immune system. This means you’ll get sick less often than people who don’t exercise.",
             "If you are someone who has trouble sleeping or staying asleep, then working out is your answer. Exercise helps to clear your head and helps you feel relaxed.",
             "That all you got?",
             "I got 99 problems, but I'm going to the gym to ignore all of them.",
                          "I only work out because I really, really like donuts.",
                          "Life has its ups and downs. We call them squats.",
                          "Unless you puke, faint, or die, KEEP GOING!!",
                          "You make my knewes weak, Just kidding, Yesterday was leg day.",
                          "My favorite machine at the gym is the television.",
                          "Weights before dates.",
                          "I like big weights and I cannot lie.",
                          "Sweat is your fat crying.",
                          "If you still look cute after working out, your didn't go hard enough.",
                          "Cut carbs? Sure, I can do that... *slices bread.",
                          "Eat clean, stay fit, and have a burger to stay sane.",
                          "Why run from your problems when you could be running at the gym.",
                          "I will never break up with my gym. We just seem to workout.",
]

struct ContentView: View {
    //-------------------------------Pages Bool----------------------------------------
    @State private var repCounter = false
    @State private var restRepCounter = false
    @State private var profile = false
    @State private var nice = false
    @State private var calender = false
    @State private var hasRated = false
    @State private var isBad = false
    @State private var isGood = false
    @AppStorage("isRegistered") private var isRegistered = false
    
    //-------------------------------Saved Data----------------------------------------
    @AppStorage("fName") private var fName: String = ""
    @AppStorage("lName")private var lName: String = ""
    @AppStorage("weight") private var weight: Int = 0
    @AppStorage("feet") private var feet: Int = 0
    @AppStorage("inch") private var inch: Int = 0
    @AppStorage("age") private var age: Int = 0
    @AppStorage("Slifetime") private var Slifetime: Int = 0
    @AppStorage("Mlifetime") private var Mlifetime: Int = 0
    @AppStorage("Hlifetime") private var Hlifetime: Int = 0
    @AppStorage("Dlifetime") private var Dlifetime: Int = 0
    @AppStorage("tSets") private var tSets: Int = 0
    @AppStorage("tReps") private var tReps: Int = 0
    
    //-------------------------------Not Saved Data----------------------------------------
    
    @State public var maxSet = 3
    @State public var maxRep = 8
    @State public var set = 0
    @State public var rep = 0
    @State public var date = Date()
    @State private var timeRemaining = 0
    @State private var restTimeM = 1
    @State private var restTimeS = 0
    @State private var min = 0
    
    var randomReps = 0
    var randomSets = 0
    var randomM = 0
    var randomS = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let motionManager = CMMotionManager()
    let queue = OperationQueue()
    @State private var flag1 = 0
    @State private var flag2 = 0
    let randomInt = Int.random(in: 1...quote.count-1)
    
    //-------------------------------Misc Data----------------------------------------
    var disableForm: Bool {
        fName.count < 2 || lName.count < 2
    }

    
    //-------------------------------PROFILE----------------------------------------
    var body: some View {
        
        //-------------------------------NOT Logged In----------------------------------------
        if !isRegistered{
            ZStack{
                Color(purple)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Image("JIMlogo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                    Text("Enter Information")
                        .foregroundColor(Color(.white))
                        .font(.custom( "Avenir Next Condensed", size: 30) .weight(.bold))
                    HStack{
                        TextField(" First Name", text: $fName)
                            .frame(width:150 , height: 40)
                            .font(.custom( "Avenir Next Condensed", size: 25) .weight(.bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(dark))
                            .background(Color(.white))
                            .cornerRadius(25.0)
                        TextField(" Last name", text: $lName)
                            .frame(width:150 , height: 40)
                            .font(.custom( "Avenir Next Condensed", size: 25) .weight(.bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(dark))
                            .background(Color(.white))
                            .cornerRadius(25.0)
                    }
                    HStack{
                        Button{
                            if weight > 10{
                                weight -= 10
                            }
                        }label: {
                            Text("-10")
                                .frame(width: 60, height: 60)
                                .edgesIgnoringSafeArea(.all)
                                .background(Color(oppGreen))
                                .foregroundColor(.white)
                                .font(.custom( "Avenir Next Condensed", size: 25) .weight(.bold))
                                .cornerRadius(100.0)
                        }
                        Button{
                            if weight > 1{
                                weight -= 1
                            }
                        }label: {
                            Text("-1")
                                .frame(width: 50, height: 50)
                                .edgesIgnoringSafeArea(.all)
                                .background(Color(oppGreen))
                                .foregroundColor(.white)
                                .font(.custom( "Avenir Next Condensed", size: 25) .weight(.bold))
                                .cornerRadius(100.0)
                        }
                        Text(weight.description + " lbs.")
                            .foregroundColor(Color(.white))
                            .font(.custom( "Avenir Next Condensed", size: 30) .weight(.bold))
                            .padding([.trailing, .leading])
                        Button{
                                weight += 1
                        }label: {
                            Text("+1")
                                .frame(width: 50, height: 50)
                                .edgesIgnoringSafeArea(.all)
                                .background(Color(green))
                                .foregroundColor(.white)
                                .font(.custom( "Avenir Next Condensed", size: 25) .weight(.bold))
                                .cornerRadius(100.0)
                        }
                        Button{
                                weight += 10
                        }label: {
                            Text("+10")
                                .frame(width: 60, height: 60)
                                .edgesIgnoringSafeArea(.all)
                                .background(Color(green))
                                .foregroundColor(.white)
                                .font(.custom( "Avenir Next Condensed", size: 25) .weight(.bold))
                                .cornerRadius(100.0)
                        }
                        
                    }
                    HStack{
                        Button{
                            if feet > 0{
                                feet -= 1
                            }
                        }label: {
                            Text("-1ft")
                                .frame(width: 60, height: 60)
                                .edgesIgnoringSafeArea(.all)
                                .background(Color(oppGreen))
                                .foregroundColor(.white)
                                .font(.custom( "Avenir Next Condensed", size: 25) .weight(.bold))
                                .cornerRadius(100.0)
                        }
                        Button{
                            if inch == 0 && feet > 0{
                                feet -= 1
                                inch += 11
                            }
                            else if inch > 0{
                                inch -= 1
                            }
                            
                        }label: {
                            Text("-1")
                                .frame(width: 50, height: 50)
                                .edgesIgnoringSafeArea(.all)
                                .background(Color(oppGreen))
                                .foregroundColor(.white)
                                .font(.custom( "Avenir Next Condensed", size: 25) .weight(.bold))
                                .cornerRadius(100.0)
                        }
                    
                        
                        Text(feet.description + " ft.  " + inch.description + " in.")
                            .foregroundColor(Color(.white))
                            .font(.custom( "Avenir Next Condensed", size: 30) .weight(.bold))
                            .padding([.trailing, .leading],0)
                        Button{
                            if inch == 11{
                                feet += 1
                                inch = 0
                            }
                            else{
                                inch += 1
                            }
                        }label: {
                            Text("+1")
                                .frame(width: 50, height: 50)
                                .edgesIgnoringSafeArea(.all)
                                .background(Color(green))
                                .foregroundColor(.white)
                                .font(.custom( "Avenir Next Condensed", size: 25) .weight(.bold))
                                .cornerRadius(100.0)
                        }
                        Button{
                             feet += 1
                        }label: {
                            Text("+1ft")
                                .frame(width: 60, height: 60)
                                .edgesIgnoringSafeArea(.all)
                                .background(Color(green))
                                .foregroundColor(.white)
                                .font(.custom( "Avenir Next Condensed", size: 25) .weight(.bold))
                                .cornerRadius(100.0)
                        }
                    }
                    HStack{
                        Button{
                            if age > 9{
                                age -= 10
                            }
                        }label: {
                            Text("-10")
                                .frame(width: 60, height: 60)
                                .edgesIgnoringSafeArea(.all)
                                .background(Color(oppGreen))
                                .foregroundColor(.white)
                                .font(.custom( "Avenir Next Condensed", size: 25) .weight(.bold))
                                .cornerRadius(100.0)
                        }
                        Button{
                            if age > 1{
                                age -= 1
                            }
                        }label: {
                            Text("-1")
                                .frame(width: 50, height: 50)
                                .edgesIgnoringSafeArea(.all)
                                .background(Color(oppGreen))
                                .foregroundColor(.white)
                                .font(.custom( "Avenir Next Condensed", size: 25) .weight(.bold))
                                .cornerRadius(100.0)
                        }
                        Text(age.description + " Years Old")
                            .foregroundColor(Color(.white))
                            .font(.custom( "Avenir Next Condensed", size: 20) .weight(.bold))
                        Button{
                            if age < 100{
                                age += 1
                            }
                        }label: {
                            Text("+1")
                                .frame(width: 50, height: 50)
                                .edgesIgnoringSafeArea(.all)
                                .background(Color(green))
                                .foregroundColor(.white)
                                .font(.custom( "Avenir Next Condensed", size: 25) .weight(.bold))
                                .cornerRadius(100.0)
                        }
                        Button{
                            if age < 91{
                                age += 10
                            }
                        }label: {
                            Text("+10")
                                .frame(width: 60, height: 60)
                                .edgesIgnoringSafeArea(.all)
                                .background(Color(green))
                                .foregroundColor(.white)
                                .font(.custom( "Avenir Next Condensed", size: 25) .weight(.bold))
                                .cornerRadius(100.0)
                        }
                    }
                    Section{
                        Button{
                            isRegistered = true
                        }label: {
                            if disableForm{
                                Text("Done")
                                    .frame(width: 300, height: 100)
                                    .edgesIgnoringSafeArea(.all)
                                    .background(Color(.gray))
                                    .foregroundColor(.white)
                                    .font(.custom( "Avenir Next Condensed", size: 40) .weight(.bold))
                                    .cornerRadius(100.0)
                            }
                            if !disableForm{
                                Text("Done")
                                    .frame(width: 300, height: 100)
                                    .edgesIgnoringSafeArea(.all)
                                    .background(Color(green))
                                    .foregroundColor(.white)
                                    .font(.custom( "Avenir Next Condensed", size: 40) .weight(.bold))
                                    .cornerRadius(100.0)
                            }
                        }
                        .disabled(disableForm)
                    }
                    Spacer()
                }
            }
        }
        
        
        
        //-------------------------------Logged In----------------------------------------
        if isRegistered{
            TabView {

                
                //-------------------------------Rep Counter----------------------------------------
                
                ZStack{
                    if !restRepCounter{
                    Color(purple)
                        .edgesIgnoringSafeArea(.all)
                        .onReceive(timer) { time in
                            if timeRemaining <= 59 && repCounter
                            {
                                timeRemaining += 1
                            }
                            else if timeRemaining > 59 && repCounter
                            {
                                timeRemaining = 0
                                min += 1
                            }
                            
                            // TOTAL GYM TIME
                            
                            
                            motionManager.gyroUpdateInterval = 0.1
                            
                            motionManager.startGyroUpdates(to: OperationQueue.current!) { (data, error) in
                                if let data = data {
                                    let rotationRate = data.rotationRate
                                    if repCounter  && !nice{
                                        
                                        if rotationRate.x >= 1.2 {
                                            flag1 = 1
                                        }
                                        else if rotationRate.y >= 1.25{
                                            flag1 = 0
                                        }
                                        else if rotationRate.x <= -1.2 {
                                            flag2 = 1
                                        }
                                        else if rotationRate.y <= -1.25{
                                            flag2 = 0
                                        }
                                        else if flag1 == flag2 && flag1 != 0 && flag2 != 0 {
                                            tReps += 1
                                            rep += 1
                                            flag1 = 0
                                            flag2 = 0
                                        }
                                        // Start the timer if the user has reached the max reps
                                        else if rep >= maxRep {
                                            calculateTime()
                                            tSets += 1
                                            set += 1
                                            rep = 0
                                            restTimeM = 1
                                            restTimeS = 0
                                            isGood = false
                                            isBad = false
                                            hasRated = false
                                            restRepCounter = true
                                            repCounter.toggle()
                                            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {   }
                                            
                                            // Stop counting reps after 3 timers have started
                                            if set == maxSet {
                                                nice = true
                                                restRepCounter = false
                                                set = 0
                                                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {   }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        VStack{
                            Text("Set " + set.description + " of " + maxSet.description)
                                .font(.custom( "Avenir Next Condensed", size: 75) .weight(.bold))
                                .foregroundColor(.white)
                                .padding([.top])
                                .padding([.bottom], 1)
                            
                            Image("flex")
                                .resizable()
                                .scaledToFit()
                            if !nice{
                                Text(rep.description + " / " + maxRep.description)
                                    .foregroundColor(.white)
                                    .font(.system(size: 90, weight: .bold, design: .default))
                                    .padding([.top],1)
                            }
                            else if nice && !repCounter{
                                Text("Nicely Done")
                                    .foregroundColor(.white)
                                    .font(.system(size: 50, weight: .bold, design: .default))
                                    .padding([.top],1)
                            }
                            HStack{
                                Text("Time elapsed: ")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30, weight: .medium, design: .default))
                                    .font(Font.largeTitle.monospacedDigit())
                                Text(min.description + "m " + timeRemaining.description + "s")
                                    .foregroundColor(.white)
                                    .font(Font.largeTitle.monospacedDigit())
                            }
                            HStack{
                                Text("Number of Sets ")
                                    .frame(width: 200, height: 50)
                                    .font(.system(size: 25, weight: .medium, design: .default))
                                    .foregroundColor(.white)
                                Button{
                                    if maxSet > 1{
                                        maxSet -= 1
                                    }
                                }label: {
                                    Text("-1")
                                        .frame(width: 50, height: 50)
                                        .edgesIgnoringSafeArea(.all)
                                        .background(Color(oppGreen))
                                        .foregroundColor(.white)
                                        .font(.system(size:25, weight: .bold, design: .default))
                                        .cornerRadius(100.0)
                                        .padding(.leading)
                                }
                                Button{
                                    if maxSet < 10{
                                        maxSet += 1
                                    }
                                    
                                    
                                }label: {
                                    Text("+1")
                                        .frame(width: 50, height: 50)
                                        .edgesIgnoringSafeArea(.all)
                                        .background(Color(green))
                                        .foregroundColor(.white)
                                        .font(.system(size:25, weight: .bold, design: .default))
                                        .cornerRadius(100.0)
                                        .padding(.leading)
                                }
                            }
                            HStack{
                                Text("Number of Reps")
                                    .frame(width: 200, height: 50)
                                    .font(.system(size: 25, weight: .medium, design: .default))
                                    .foregroundColor(.white)
                                Button{
                                    if maxRep > 1{
                                        maxRep -= 1
                                    }
                                }label: {
                                    Text("-1")
                                        .frame(width: 50, height: 50)
                                        .edgesIgnoringSafeArea(.all)
                                        .background(Color(oppGreen))
                                        .foregroundColor(.white)
                                        .font(.system(size:25, weight: .bold, design: .default))
                                        .cornerRadius(100.0)
                                        .padding(.leading)
                                }
                                Button{
                                    if maxRep < 20{
                                        maxRep += 1
                                    }
                                }label: {
                                    Text("+1")
                                        .frame(width: 50, height: 50)
                                        .edgesIgnoringSafeArea(.all)
                                        .background(Color(green))
                                        .foregroundColor(.white)
                                        .font(.system(size:25, weight: .bold, design: .default))
                                        .cornerRadius(100.0)
                                        .padding(.leading)
                                }
                            }
                            HStack{
                                Button(){
                                    repCounter.toggle()
                                    nice = false
                                }label: {
                                    if repCounter {
                                        
                                        Text("Pause Workout")
                                            .frame(width: 250, height: 70)
                                            .edgesIgnoringSafeArea(.all)
                                            .background(Color(green))
                                            .foregroundColor(.white)
                                            .font(.system(size:20, weight: .bold, design: .default))
                                            .cornerRadius(3.0)
                                            .padding([.bottom])
                                    }
                                    else{
                                        
                                        Text("Start Workout")
                                            .frame(width: 250, height: 70)
                                            .edgesIgnoringSafeArea(.all)
                                            .background(Color(green))
                                            .foregroundColor(.white)
                                            .font(.system(size:20, weight: .bold, design: .default))
                                            .cornerRadius(3.0)
                                            .padding([.bottom])
                                    }
                                }
                                Button{
                                    restTimeS = 0
                                    restTimeM = 1
                                    restRepCounter = true
                                    hasRated = false
                                    isGood = false
                                    isBad = false
                                }
                                label: {
                                    Image("skip2")
                                        .resizable()
                                        .background(Color(dark))
                                        .frame(width: 70, height: 70)
                                        .cornerRadius(3.0)
                                        .padding([.bottom])
                                }
                            }
                            
                            Spacer()
                        }
                    }
                    else if restRepCounter{
                        Color(purple)
                            .ignoresSafeArea(.all)
                            .onReceive(timer) { time in
                                if restTimeM >= 0
                                {
                                    if restTimeS <= 0{
                                        restTimeS += 60
                                        restTimeM -= 1
                                    }
                                    restTimeS -= 1
                                    timeRemaining += 1
                                }
                                if restTimeM <= -1{
                                    AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {   }
                                    repCounter = true
                                    restRepCounter = false
                                }
                            }
                        VStack{
                            Text("Rest")
                                .edgesIgnoringSafeArea(.all)
                                .foregroundColor(.white)
                                .font(.system(size:75, weight: .bold, design: .default))
                                .padding(.top)
                            HStack{
                                Text(restTimeM.description)
                                    .edgesIgnoringSafeArea(.all)
                                    .foregroundColor(.white)
                                    .font(.system(size:70, weight: .bold, design: .default))
                                    .frame(width: 150, height: 150)
                                    .background(Color(green))
                                    .cornerRadius(20.0)
                                Text(":")
                                    .edgesIgnoringSafeArea(.all)
                                    .foregroundColor(.white)
                                    .font(.system(size:80, weight: .bold, design: .default))
                                    .cornerRadius(20.0)
                                
                                Text(restTimeS.description)
                                    .edgesIgnoringSafeArea(.all)
                                    .foregroundColor(.white)
                                    .font(.system(size:70, weight: .bold, design: .default))
                                    .frame(width: 150, height: 150)
                                    .background(Color(green))
                                    .cornerRadius(20.0)
                            }
                            HStack{
                                Button{
                                    restTimeS -= 1
                                }label: {
                                    Text("-1s")
                                        .frame(width: 50, height: 50)
                                        .edgesIgnoringSafeArea(.all)
                                        .background(Color(oppGreen))
                                        .foregroundColor(.white)
                                        .font(.system(size:25, weight: .bold, design: .default))
                                        .cornerRadius(100.0)
                                        .padding()
                                }
                                Button{
                                    if restTimeM != 0{
                                        restTimeM -= 1
                                    }
                                }label: {
                                    Text("-1m")
                                        .frame(width: 60, height: 60)
                                        .edgesIgnoringSafeArea(.all)
                                        .scaledToFit()
                                        .background(Color(oppGreen))
                                        .foregroundColor(.white)
                                        .font(.system(size:25, weight: .bold, design: .default))
                                        .cornerRadius(100.0)
                                        .padding()
                                }
                                Button{
                                    if restTimeM < 59{
                                        restTimeM += 1
                                    }
                                }label: {
                                    Text("+1m")
                                        .frame(width: 60, height: 60)
                                        .edgesIgnoringSafeArea(.all)
                                        .background(Color(green))
                                        .foregroundColor(.white)
                                        .font(.system(size:25, weight: .bold, design: .default))
                                        .cornerRadius(100.0)
                                        .padding()
                                }
                                Button{
                                    restTimeS += 1
                                    if restTimeS >= 60{
                                        restTimeM += 1
                                        restTimeS = 0
                                    }
                                }label: {
                                    Text("+1s")
                                        .frame(width: 50, height: 50)
                                        .edgesIgnoringSafeArea(.all)
                                        .background(Color(green))
                                        .foregroundColor(.white)
                                        .font(.system(size: 25, weight: .bold, design: .default))
                                        .cornerRadius(100.0)
                                        .padding()
                                }
                            }
                            Image("meme3")
                                .resizable()
                                .scaledToFit()
                            Text("'" + quote[randomInt] + "' -some guy")
                                .italic()
                                .font(.custom("Avenir Next Condensed", size: 20).weight(.medium))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                            HStack{
                                    Text("How are you feeling? ")
                                    .font(.custom( "Avenir Next Condensed", size: 25) .weight(.bold))
                                    .foregroundColor(.white)
                                Button{
                                    if !hasRated{
                                        maxRep -= 1
                                        hasRated = true
                                        isGood = false
                                        isBad = true
                                    }
                                }label: {
                                    if isGood{
                                        Image(systemName: "hand.thumbsdown.fill")
                                            .frame(width: 50, height: 50)
                                            .background(Color(.gray))
                                            .foregroundColor(.white)
                                            .cornerRadius(100.0)
                                            .padding(.leading)
                                    }
                                    else{
                                        Image(systemName: "hand.thumbsdown.fill")
                                            .frame(width: 50, height: 50)
                                            .background(Color(oppGreen))
                                            .foregroundColor(.white)
                                            .cornerRadius(100.0)
                                            .padding(.leading)
                                    }
                                            
                                    }
                                
                                Button{
                                    if !hasRated{
                                        maxRep += 1
                                        isGood = true
                                        hasRated = true
                                        isBad = false
                                    }
                                }label: {
                                    if isBad{
                                        Image(systemName: "hand.thumbsup.fill")
                                            .frame(width: 50, height: 50)
                                            .background(Color(.gray))
                                            .foregroundColor(.white)
                                            .cornerRadius(100.0)
                                    }
                                    else{
                                        Image(systemName: "hand.thumbsup.fill")
                                            .frame(width: 50, height: 50)
                                            .background(Color(green))
                                            .foregroundColor(.white)
                                            .cornerRadius(100.0)
                                    }
                                        
                                    }
                                }

                            Button{
                                restTimeS = 0
                                restTimeM = 0
                            }label: {
                                Text("Skip")
                                    .frame(width: 250, height: 70)
                                    .edgesIgnoringSafeArea(.all)
                                    .background(Color(dark))
                                    .foregroundColor(.white)
                                    .font(.system(size:30, weight: .bold, design: .default))
                                    .cornerRadius(100.0)
                                    .padding(.bottom)
                            }
                        }
                    }
                }
                .tabItem {
                        Image(systemName: "figure.strengthtraining.traditional")
                        .foregroundStyle(Color(green))


                    }

                
                
                
                
                //-------------------------------Calendar----------------------------------------
                ZStack{
                    Color(purple)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Text("Your Workouts")
                            .foregroundColor(.white)
                            .font(.custom( "Avenir Next Condensed", size: 30) .weight(.bold))
                        DatePicker(
                            "Start Date",
                            selection: $date,
                            displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .colorScheme(.dark)
                        .accentColor(Color(green))
                        .onChange(of: date, perform: { value in
                            _ = Int.random(in: 3..<10)
                            _ = Int.random(in: 3..<10)
                            _ = Int.random(in: 0..<5)
                            _ = Int.random(in: 0..<59)
                        })
                        Spacer()
                    }
                    VStack {
                        
                        let randomReps = Int.random(in: 3..<10)
                        let randomSets = Int.random(in: 3..<10)
                        let randomM = Int.random(in: 0..<5)
                        let randomS = Int.random(in: 0..<59)
                        Text("Workout Summary:")
                            .foregroundColor(.white)
                            .font(.custom( "Avenir Next Condensed", size: 30) .weight(.bold))
                            .offset(y: 150)
                        Text("Total Reps Completed: \(randomReps)")
                            .foregroundColor(.white)
                            .font(.custom( "Avenir Next Condensed", size: 20) .weight(.medium))
                            .offset(y: 150)
                        Text("Total Sets completed: \(randomSets)")
                            .foregroundColor(.white)
                            .font(.custom( "Avenir Next Condensed", size: 20) .weight(.medium))
                            .offset(y: 150)
                        Text("Total Time Elapsed:")
                            .foregroundColor(.white)
                            .font(.custom( "Avenir Next Condensed", size: 20) .weight(.medium))
                            .offset(y: 150)
                        HStack{
                            Text("\(randomM)M ")
                                .foregroundColor(.white)
                                .font(.custom( "Avenir Next Condensed", size: 18) .weight(.medium))
                                .offset(y: 150)
                            Text("\(randomS)S ")
                                .foregroundColor(.white)
                                .font(.custom( "Avenir Next Condensed", size: 18) .weight(.medium))
                                .offset(y: 150)

                        }
                    }
                    
                }
                .tabItem {
                        Image(systemName: "calendar")
                        .foregroundStyle(Color(green))

                    }
                
                
                //-------------------------------PROFILE----------------------------------------
                    ZStack{
                        Color(purple)
                            .edgesIgnoringSafeArea(.all)
                        VStack{
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .foregroundColor(.white)
                                .scaledToFit()
                            Text(fName + " " + lName)
                                .foregroundColor(.white)
                                .font(.custom( "Avenir Next Condensed", size: 40) .weight(.medium))
                            Text("Age: " + age.description)
                                .foregroundColor(.white)
                                .font(.custom( "Avenir Next Condensed", size: 30) .weight(.medium))
                                .padding([.top], 1)
                            Text("Weight: " + weight.description + "lbs")
                                .foregroundColor(.white)
                                .font(.custom( "Avenir Next Condensed", size: 30) .weight(.medium))
                            
                            Text("Height: " + feet.description + "ft. " + inch.description + "in.")
                                .foregroundColor(.white)
                                .font(.custom( "Avenir Next Condensed", size: 30) .weight(.medium))
                            Text("Time Worked Out:")
                                .foregroundColor(.white)
                                .font(.custom( "Avenir Next Condensed", size: 30) .weight(.medium))
                            HStack{
                                Text(Dlifetime.description + "D ")
                                    .foregroundColor(.white)
                                    .font(.custom( "Avenir Next Condensed", size: 28) .weight(.medium))
                                Text(Hlifetime.description + "H ")
                                    .foregroundColor(.white)
                                    .font(.custom( "Avenir Next Condensed", size: 28) .weight(.medium))
                                Text(Mlifetime.description + "M ")
                                    .foregroundColor(.white)
                                    .font(.custom( "Avenir Next Condensed", size: 28) .weight(.medium))
                                Text(Slifetime.description + "S ")
                                    .foregroundColor(.white)
                                    .font(.custom( "Avenir Next Condensed", size: 28) .weight(.medium))

                            }
                            Text("Total Sets: " + tSets.description)
                                .foregroundColor(.white)
                                .font(.custom( "Avenir Next Condensed", size: 30) .weight(.medium))
                            Text("Total Reps: " + tReps.description)
                                .foregroundColor(.white)
                                .font(.custom( "Avenir Next Condensed", size: 30) .weight(.medium))
                            
                            Spacer()
                        }
                }
                .tabItem {
                    Image(systemName: "person.fill")
                        .foregroundStyle(Color(green))

                }
                
                
                
            }
            
            
            .font(.headline)
        }
        
    }
    func calculateTime(){
        Slifetime += timeRemaining
        Mlifetime += min
        if Slifetime >= 60{
            Mlifetime += 1
            Slifetime = 0
        }
        if Mlifetime >= 60{
            Hlifetime += 1
            Mlifetime = 0
        }
        if Hlifetime >= 24{
            Dlifetime += 1
            Hlifetime = 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
