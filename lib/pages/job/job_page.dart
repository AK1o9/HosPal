import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/style.dart';
import '../../widgets/text_poppins_widget.dart';

class JobPage extends StatefulWidget {
  // final id;

  const JobPage({Key? key}) : super(key: key);

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: PoppinsTextWidget(
            text: 'GigHub',
            color: light,
            size: fontTitle,
            isBold: true,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: dark,
          leading: Padding(
              padding: EdgeInsets.only(
                  left: space18, top: space12, right: space12, bottom: space12),
              child: Icon(Icons.menu_rounded, color: light, size: 28)),
          actions: [
            Icon(Icons.person, color: light, size: 28),
            x10,
            x8,
          ],
        ),
        body: Column(
          children: <Widget>[
            y20,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 15, left: 200),
                    child: PoppinsTextWidget(
                      text: 'Job Details',
                      size: fontHeader,
                      color: dark,
                      isBold: true,
                    )),
              ],
            ),
            y10,
            y4,
            Padding(
              padding: const EdgeInsets.only(left: 170, right: 170),
              child: SizedBox(
                height: 500,
                child: Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.black.withOpacity(.4), width: .5),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 6),
                              color: Colors.grey.withOpacity(.1),
                              blurRadius: 12)
                        ],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 4,
                            child: Center(
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: PoppinsTextWidget(
                                    text: "IT Intern",
                                    size: fontSubtitle,
                                    color: dark,
                                    isBold: true,
                                  ),
                                ),
                                Divider(
                                  thickness: 0.5,
                                  color: Colors.black.withOpacity(.4),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Mobile App Development",
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.lightBlue),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Posted 6 hours ago",
                                        style: GoogleFonts.roboto(
                                            fontSize: 15,
                                            color:
                                                Colors.black.withOpacity(.4)),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 10),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.location_on,
                                          color: Colors.blue),
                                      x8,
                                      Text("Kuala Lumpur, Malaysia")
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 0.5,
                                  color: Colors.black.withOpacity(.4),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Job Description",
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: dark),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    "Develop application programming interfaces (APIs) to support mobile functionality while keeping up to date with terminology, concepts and best practices for coding mobile apps using flutter.",
                                    style: GoogleFonts.roboto(
                                        fontSize: 15, color: dark, height: 1.7),
                                  ),
                                ),
                                Divider(
                                  thickness: 0.5,
                                  color: Colors.black.withOpacity(.4),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.monetization_on,
                                                  color: dark),
                                              Text(
                                                "  RM 1250 - 2500",
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: dark),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 30),
                                            child: Text(
                                              "Monthly",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 13,
                                                  color: dark.withOpacity(.4)),
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.calendar_month,
                                                  color: dark),
                                              Text(
                                                "  3 - 6 months",
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: dark),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Text(
                                              "Duration",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 13,
                                                  color: dark.withOpacity(.4)),
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.category, color: dark),
                                              Text(
                                                "  Internship",
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: dark),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              " Job type",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 13,
                                                  color: dark.withOpacity(.4)),
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.psychology,
                                                  color: dark),
                                              Text(
                                                "  Intermediate",
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: dark),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "Job Level",
                                            style: GoogleFonts.roboto(
                                                fontSize: 13,
                                                color: dark.withOpacity(.4)),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Divider(
                                    thickness: 0.5,
                                    color: Colors.black.withOpacity(.4),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 20),
                                  child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Job Requirements & Skills",
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: dark),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 15, top: 10),
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          border: Border.all(
                                              color: dark.withOpacity(.4)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "Bachelor's Degree",
                                        style: GoogleFonts.roboto(
                                            fontSize: 13, color: dark),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 15, top: 10),
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          border: Border.all(
                                              color: dark.withOpacity(.4)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "Mobile App Development",
                                        style: GoogleFonts.roboto(
                                            fontSize: 13, color: dark),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 15, top: 10),
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          border: Border.all(
                                              color: dark.withOpacity(.4)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "Web Development",
                                        style: GoogleFonts.roboto(
                                            fontSize: 13, color: dark),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 15, top: 10),
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          border: Border.all(
                                              color: dark.withOpacity(.4)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "IOS",
                                        style: GoogleFonts.roboto(
                                            fontSize: 13, color: dark),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 15, top: 10),
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          border: Border.all(
                                              color: dark.withOpacity(.4)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "Android",
                                        style: GoogleFonts.roboto(
                                            fontSize: 13, color: dark),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 15, top: 10),
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          border: Border.all(
                                              color: dark.withOpacity(.4)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "Communication Skills",
                                        style: GoogleFonts.roboto(
                                            fontSize: 13, color: dark),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 15, top: 10),
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          border: Border.all(
                                              color: dark.withOpacity(.4)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "Teamwork",
                                        style: GoogleFonts.roboto(
                                            fontSize: 13, color: dark),
                                      ),
                                    ),
                                  ],
                                )
                              ]),
                            ),
                          ),
                          VerticalDivider(
                            thickness: 0.5,
                            color: Colors.black.withOpacity(.4),
                          ),
                          Flexible(
                              flex: 2,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: SizedBox(
                                      height: 40,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            primary: dark,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30))),
                                        child: Center(
                                          child: PoppinsTextWidget(
                                              text: "Apply",
                                              size: fontLabel,
                                              color: light),
                                        ),
                                      ),
                                    ),
                                  ),
                                  y10,
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: SizedBox(
                                      height: 40,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            primary: light,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.favorite,
                                              color: Colors.black,
                                            ),
                                            x10,
                                            PoppinsTextWidget(
                                                text: "Save Job",
                                                size: fontLabel,
                                                color: dark),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  y10,
                                  Divider(
                                    thickness: 0.5,
                                    color: Colors.black.withOpacity(.4),
                                  ),
                                  y10,
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "About the company",
                                          style: GoogleFonts.oswald(
                                              color: dark,
                                              fontSize: fontHeader,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  y8,
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Name: ",
                                          style: GoogleFonts.openSans(
                                              color: dark.withOpacity(.4),
                                              fontSize: fontLabel),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Text(
                                            "Teczo Sdn Bhd",
                                            style: GoogleFonts.openSans(
                                                color: dark.withOpacity(.4),
                                                fontSize: fontLabel),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  y8,
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Location: ",
                                          style: GoogleFonts.openSans(
                                              color: dark.withOpacity(.4),
                                              fontSize: fontLabel),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Text(
                                            "Kuala Lumpur, Malaysia",
                                            style: GoogleFonts.openSans(
                                                color: dark.withOpacity(.4),
                                                fontSize: fontLabel),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  y8,
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Description: ",
                                          style: GoogleFonts.openSans(
                                              color: dark.withOpacity(.4),
                                              fontSize: fontLabel),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Text(
                                            "IT Services provider",
                                            style: GoogleFonts.openSans(
                                                color: dark.withOpacity(.4),
                                                fontSize: fontLabel),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  y8,
                                  Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Logo",
                                              style: GoogleFonts.openSans(
                                                  color: dark.withOpacity(.4),
                                                  fontSize: fontLabel),
                                            ),
                                          ])),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      Icon(Icons.image,
                                          size: 200, color: Colors.black),
                                    ],
                                  )
                                ],
                              )),
                        ],
                      )),
                ),
              ),
            )
          ],
        ));
  }
}
