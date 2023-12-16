import time
import cv2 as cv
import mediapipe as mp
import numpy as np
import os
import tensorflow as tf
import cv2
import matplotlib.pyplot as plt
import face_recognition
from PIL import Image, ImageDraw
src = 'C:/Users/Cy/Desktop/Facial Recognition/kjo/images/'
recent_model = tf.keras.models.load_model('C:/Users/Cy/Desktop/Facial Recognition/my_model.h5')
diction = {}

person_encodings = np.load('C:/Users/Cy/Desktop/Facial Recognition/encodingmodel/face_encodings.npy')
with open("sample.txt", "r") as f:
    for i, names in enumerate(f):
        diction[i] = names.strip()

        

    # Display the resulting image
    #display(pil_image)

def getEuclideanDist(vector1, vector2):
    return np.linalg.norm(vector1-vector2)

def match(img_encode):
    for persons in person_encodings:
        h = getEuclideanDist(persons, img_encode)
        num.append(h)





mp_face_detection = mp.solutions.face_detection
cap = cv.VideoCapture(0)
with mp_face_detection.FaceDetection(model_selection=1, min_detection_confidence=0.5) as face_detector:
    frame_counter = 0
    fonts = cv.FONT_HERSHEY_PLAIN
    cv.namedWindow("frame")
    cv.setWindowProperty("frame", cv.WND_PROP_FULLSCREEN, cv.WINDOW_FULLSCREEN)
    start_time = time.time()
    while True:
        
        
        frame_counter += 1
        ret, frame = cap.read()
        if ret is False:
            break
        rgb_frame = cv.cvtColor(frame, cv.COLOR_BGR2RGB)

        results = face_detector.process(rgb_frame)
        frame_height, frame_width, c = frame.shape
        if results.detections:
            for face in results.detections:
                face_react = np.multiply(
                    [
                        face.location_data.relative_bounding_box.xmin,
                        face.location_data.relative_bounding_box.ymin,
                        face.location_data.relative_bounding_box.width,
                        face.location_data.relative_bounding_box.height,
                    ],
                    [frame_width, frame_height, frame_width, frame_height]).astype(int)
                
                # Extract the region of interest (ROI)
                x, y, w, h = face_react
                roi = frame[y:y + h, x:x + w]
                
                #roi = cv2.resize(roi,(1280,720))
                # Save the ROI as a PNG image
                cv.imwrite(src+"face_roi.png", roi)
                unknown_image = face_recognition.load_image_file(src+"face_roi.png")
                
                face_encode = face_recognition.face_encodings(unknown_image)
                if face_encode:
                    img_encode = face_encode[0]
                    
                
                    num = []
                    match(img_encode)
                    
                    temp = np.array(num)
                    if temp[np.argmin(temp)] < 0.45:
                        print(temp[np.argmin(temp)]) 
                        print(diction[np.argmin(temp)]) 

                        cv.putText(frame,f"Name: {diction[np.argmin(temp)]}, Score: {temp[np.argmin(temp)]}",(90, 90),cv.FONT_HERSHEY_DUPLEX,0.7,(0, 255, 255),2,)
                        cv.rectangle(frame, face_react, color=(255, 255, 255), thickness=2)
                        
                        key_points = np.array([(p.x, p.y) for p in face.location_data.relative_keypoints])
                        key_points_coords = np.multiply(key_points,[frame_width,frame_height]).astype(int)
                        #for p in key_points_coords:
                            #cv.circle(frame, p, 4, (255, 255, 255), 2)
                            #cv.circle(frame, p, 2, (0, 0, 0), -1)
                else:
                    print('None')
            
        
        fps = frame_counter / (time.time() - start_time)
        cv.putText(frame,f"FPS: {fps:.2f}",(30, 30),cv.FONT_HERSHEY_DUPLEX,0.7,(0, 255, 255),2,)
        cv.imshow("frame", frame)
        key = cv.waitKey(1)
        if key == ord("q"):
            break
    cap.release()
    cv.destroyAllWindows() 
